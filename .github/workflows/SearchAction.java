package ken.act;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import ken.bean.Item;
import ken.dao.SearchDAO;

public class SearchAction extends Action {

	@Override
	public String execute(HttpServletRequest request) throws Exception {
		String keyword = request.getParameter("keyword");
		String genre = request.getParameter("genre");

		SearchDAO sDAO = new SearchDAO();
		ArrayList<Item> list = sDAO.search_table(keyword, genre);

		HttpSession session = request.getSession(true);
		session.setAttribute("table_items", list);
		if (list.size() == 0) {
			request.setAttribute("no_item", "");
		}

		return "/top.jsp";
	}
}
