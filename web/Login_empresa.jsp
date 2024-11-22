<%@ page import="java.sql.*" %>

<%
    // Obt�m os par�metros de email e senha do formul�rio de login
    String email = request.getParameter("email");
    String senha = request.getParameter("senha");

    // Configura��es do banco de dados
    String jdbcUrl = "jdbc:mysql://yacsu.mysql.database.azure.com:3306/controle_estoque?zeroDateTimeBehavior=CONVERT_TO_NULL";
    String jdbcUser = "Yacsu77";
    String jdbcPassword = "pedro123@";

    try {
        // Conecta ao banco de dados
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conexao = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);

        // Consulta para verificar se o usu�rio existe
        String sql = "SELECT * FROM empresas WHERE email = ? AND senha = ?";
        PreparedStatement stmt = conexao.prepareStatement(sql);
        stmt.setString(1, email);
        stmt.setString(2, senha);

        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            // Usu�rio autenticado com sucesso
           response.sendRedirect("Inicio.jsp?id=" + rs.getString("id") + "&nome_empresa=" + rs.getString("nome_empresa"));

        } else {
            // Usu�rio ou senha inv�lidos
            response.sendRedirect("Login_empresa.html");

        }

        // Fecha recursos
        rs.close();
        stmt.close();
        conexao.close();
    } catch (Exception e) {
        e.printStackTrace();
         out.print("<a href=\"erro.html\">" +"</a>");
    }
%>

