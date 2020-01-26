package ken.act;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import ken.bean.Item;

public class CheckAction extends Action {

	@Override
	public String execute(HttpServletRequest request) throws Exception {
		//セッションチェック
		HttpSession session = request.getSession(false);
		if (session == null) return "/irregular_error.jsp";

		//セッションオブジェクトよりカート情報の取得
		@SuppressWarnings("unchecked")
		ArrayList<Item> list = (ArrayList<Item>)session.getAttribute("cart");

		//カート情報が取得できないか、カートに商品がない場合
		if (list == null || list.size() == 0) {
			return "/error.jsp";
		}
		//カート情報が取得でき、カートに商品が1件以上存在する場合
		else {
			return "/cart.jsp";
		}
	}
}