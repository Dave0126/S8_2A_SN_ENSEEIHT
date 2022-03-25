package pack;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class servlet
 */
@WebServlet("/servlet")
public class servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Facade f;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public servlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		String op = request.getParameter("op");
		switch (op) {
			case "associer":
				request.getAttribute("lp", f.listePersonne(1));
				request.getAttribute("la", f.listeAdresse(1));
				request.getRequestDispatcher("choix.jsp").forward(request,  response);
				return;
				
			case "listePersonne":
				f.listePersonne();
				
			case "listeAdresse":
				f.listeAdresse();
				
			case "ajoutP":
				String nom = request.getParameter("nom");
				String prenom = request.getParameter("Prenom");
				f.ajoutPersonne(nom, prenom);
				request.getRequestDispatcher("index.html").forward(request, response);
				
			case "ajoutA":
				String rue = request.getParameter("rue");
				String ville = request.getParameter("ville");
				f.ajoutAdresse(rue, ville);
				request.getRequestDispatcher("index.html").forward(request, response);
				
			case "valider":
				int idP = Integer.parseInt(request.getParameter("idP"));
				int idA = Integer.parseInt(request.getParameter("idA"));
				f.associer(idP, idA);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
