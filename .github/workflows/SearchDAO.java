package ken.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import ken.bean.Item;

public class SearchDAO {
	private Connection connection;
	private PreparedStatement p_statement_selectItems_no_key;
	private PreparedStatement p_statement_selectItems;

	public SearchDAO() throws ClassNotFoundException, SQLException {
		 /*
			MySQLへ接続
		  */
		 String url = "jdbc:mysql://localhost:3306/latte_station";
		 String user = "root";
		 String password = "root";
		 connection = DriverManager.getConnection(url, user, password);

		 /*
			PrepareStatementの利用。
			最初に枠となるSQLを設定する。
		  */
		 // ?(INパラメータ)のところは、後から設定できる。
		 String sql1 = "SELECT * FROM latte_station.item WHERE genre_id=?";
		 String sql2 = "SELECT * FROM latte_station.item WHERE genre_id=? and (item_name like ? or artist like ?)";

		 //商品情報をジャンルのみで検索するためのSQL
		 p_statement_selectItems_no_key = connection.prepareStatement(sql1);
		 //商品情報をジャンルとキーワードで検索するためのSQL
		 p_statement_selectItems = connection.prepareStatement(sql2);
	}

	 /**
		商品検索メソッド
		@param ユーザーが入力したキーワード
		@param ユーザーが選択したジャンル
		@return 商品一覧を ArrayList 型で返す
	  */
	public ArrayList<Item> search_table(String keyword, String genre) throws SQLException {
		ResultSet rs_items = null;

		//キーワードが入力された場合
		if (!keyword.equals("")) {
			p_statement_selectItems.setString(1, genre);
			p_statement_selectItems.setString(2, "%" + keyword + "%");
			p_statement_selectItems.setString(3, "%" + keyword + "%");
			rs_items = p_statement_selectItems.executeQuery();
		}
		//キーワードが未入力の場合
		else {
			p_statement_selectItems_no_key.setString(1, genre);
			rs_items = p_statement_selectItems_no_key.executeQuery();
		}

		//商品一覧用のArrayListオブジェクトの生成
		ArrayList<Item> list = new ArrayList<Item>();
		while (rs_items.next()) {
			Item item = new Item();
			item.setItemID(rs_items.getInt("item_id"));
			item.setItemName(rs_items.getString("item_name"));
			item.setItemArtist(rs_items.getString("artist"));
			item.setItemPrice(rs_items.getInt("price"));
			item.setItemImage(rs_items.getString("item_img"));
			list.add(item);
		}
		//切断処理
		if (rs_items != null) rs_items.close();
		if (connection != null) connection.close();

		return list;
	}
}