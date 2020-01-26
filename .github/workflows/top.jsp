<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ken.bean.Item"%>
<%@ page import="java.util.ArrayList"%>
<%
	@SuppressWarnings("unchecked")
	ArrayList<Item> table_items = (ArrayList<Item>)session.getAttribute("table_items");
	@SuppressWarnings("unchecked")
	ArrayList<Item> cart_items = (ArrayList<Item>)session.getAttribute("cart");

	int cart_size = 0;
	if (cart_items != null) {
		cart_size = cart_items.size();
	}
	String message = "";
	if (request.getAttribute("no_item") != null) {
		message = "該当する商品はありません。";
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="content-style-type" content="text/css" />
<link href="css/common.css" rel="stylesheet" type="text/css" media="screen" />
<link href="css/top.css" rel="stylesheet" type="text/css" media="screen" />
<title>ショッピングサイトLatteトップページ</title>
</head>
<body id="index_page">
	<div id="wrap">
		<div id="header">
			<h1><img src="img/site_id_new.png" width="204" height="120" alt="logo" /></h1>
		</div>
		<hr />
		<div id="nav">
			<ul>
				<li><a href="#">ホーム</a></li>
				<li><a href="#">ショップガイド</a></li>
				<li><a href="#">よくある質問</a></li>
				<li><a href="#">会社案内</a></li>
				<li><a href="#">お問い合わせ</a></li>
			</ul>
		</div>
		<div id="visual">
			<h2><img src="img/yokohama01.jpg" alt="Latteトップページ" width="900" height="200" /></h2>
		</div>
		<div id="main_contents">
			<h3>欲しいモノのカテゴリー選択してください</h3>
			<form action="kenshop" method="post">
				<table summary="検索欄">
					<tr>
						<td>分類</td>
						<td>
							<select name="genre">
								<option value="book" selected="selected">書籍</option>
								<option value="cd">CD</option>
								<option value="game">GAME</option>
							</select>
						</td>
						<td>キーワード</td>
						<td><input type="text" name="keyword" size="20" value="" /></td>
						<td>
							<input type="submit" name="search" value="検索" />
							<input type="hidden" name="act" value="search" />
						</td>
					</tr>
				</table>
			</form>
			<h3>現在選択されている商品</h3>
			<table width="280" border="0" cellpadding="0" cellspacing="0" summary="商品一覧">
				<tr>
					<td>選択商品 <%= cart_size %>  個</td>
					<td width="160" align="right">
						<form action="kenshop" method="post">
							<input type="image" src="img/btn_cart.gif" alt="カートの中身を見る" />
							<input type="hidden" name="act" value="check" />
						</form>
					</td>
				</tr>
			</table>
			<h3>選択カテゴリー商品</h3>
			<table width="540" border="0" cellpadding="5" cellspacing="1" bgcolor="#dddddd" summary="選択カテゴリー商品">
				<tr>
					<td width="120" align="center" bgcolor="#000000"><font color="#FFFFFF">商品</font>
					</td>
					<td align="center" bgcolor="#000000"><font color="#FFFFFF">商品名 著者 価格</font>
					</td>
					<td width="120" bgcolor="#000000"></td>
				</tr>
			</table>

<!-- ●！！！！表の作成はここから！！！！●  -->
<%
	if (table_items != null) {
		for (int i=0; i<table_items.size(); i++) {
			Item item = table_items.get(i);
%>
		<form action="kenshop" method="post">
			<div class="items">
				<div class="lineup_img"><img src="<%= item.getItemImage() %>" alt="<%= item.getItemName() %>" /></div>
				<div class="lineup">
					<%= item.getItemName() %>&nbsp;&nbsp;
					<%= item.getItemArtist() %>&nbsp;&nbsp;
					<%= item.getItemPrice() %></div>
				<div class="lineup_btn">
					<input type="image" src="img/btn_addition.gif" alt="カートに追加" />
					<input type="hidden" name="act" value="add" />
					<input type="hidden" name="id" value="<%= item.getItemID() %>" />
					<input type="hidden" name="title" value="<%= item.getItemName() %>" />
					<input type="hidden" name="create" value="<%= item.getItemArtist() %>" />
					<input type="hidden" name="price" value="<%= item.getItemPrice() %>" />
				</div>
			</div>
		</form>
<%
		}
	}
%>
<p><font color="red"><%= message %></font></p>
<!-- ↑↑↑↑表の作成はここまで↑↑↑↑  -->
		</div>
		<!-- InstanceEndEditable -->
		<hr />
		<div id="sub_contents">
			<h4>
				<img src="img/sidemn_shopguide.gif" width="96" height="15" alt="ショッピングガイド" />
			</h4>
			<ul>
				<li><a href="#">ご購入方法</a>
				</li>
				<li><a href="#">お支払い方法</a>
				</li>
				<li><a href="#">配送料</a>
				</li>
				<li><a href="#">ラッピング</a>
				</li>
				<li><a href="#">返品・交換</a>
				</li>
			</ul>
			<p>
				全国無料配送<br /> 各種クレジットカードもご利用になれます。
			</p>
			<p>販売元：株式会社シンクスバンク</p>
		</div>
		<hr />
		<div id="footer">
			<p>
				<a href="#wrap"><img src="img/page_top.gif" width="49" height="9" alt="ページトップ" />
				</a>
			</p>
			<address>&copy; 2012 Thinketh Bank Co., Ltd. All Rights Reserved.</address>
		</div>
	</div>
</body>
</html>