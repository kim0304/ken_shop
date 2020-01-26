package ken.act;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import ken.bean.Item;

public class AddAction extends Action {

	@Override
	public String execute(HttpServletRequest request) throws Exception {
		//リクエストパラメータの取得
		String id = request.getParameter("id");
		String title = request.getParameter("title");
		String create = request.getParameter("create");
		String price = request.getParameter("price");

		//Bean の作成
		Item item = new Item();
		item.setItemID(Integer.parseInt(id));
		item.setItemName(title);
		item.setItemArtist(create);
		item.setItemPrice(Integer.parseInt(price));

		//セッションの獲得
		HttpSession session = request.getSession(true);

		//カートの取得
		@SuppressWarnings("unchecked")
		ArrayList<Item> list = (ArrayList<Item>)session.getAttribute("cart");
		//セッションオブジェクト内にカート情報がない場合は新規作成
		if (list == null) {
			list = new ArrayList<Item>();
		}
		//商品の追加
		list.add(item);
		//セッションに格納
		session.setAttribute("cart", list);

		return "/top.jsp";
	}
}