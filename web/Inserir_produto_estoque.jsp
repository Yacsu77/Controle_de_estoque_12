<%@ page import="java.sql.*" %>
<%
    // Obtendo os dados do formulário
    int id = Integer.parseInt(request.getParameter("id"));
    int produtoId = Integer.parseInt(request.getParameter("produto"));
    int lojaId = Integer.parseInt(request.getParameter("loja"));
    int quantidade = Integer.parseInt(request.getParameter("quantidade"));
    String dataFabrica = request.getParameter("Fabrica");
    String dataValidade = request.getParameter("Validade");

    // Configurações de conexão com o banco de dados
    String jdbcUrl = "jdbc:mysql://yacsu.mysql.database.azure.com:3306/controle_estoque?zeroDateTimeBehavior=CONVERT_TO_NULL";
    String jdbcUser = "Yacsu77";
    String jdbcPassword = "pedro123@";

    Connection conn = null;
    PreparedStatement stmt = null;
   boolean sucesso = false; 


    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);

        // Consulta SQL para inserir os dados do produto no estoque
        String sql = "INSERT INTO estoque (Cod_Produto, Data_fabricação, Data_validade, Cod_empresa, Cod_loja) VALUES (?, ?, ?, ?,?)";
        stmt = conn.prepareStatement(sql);

        int totalInsercoes = 0;

        // Inserir várias vezes de acordo com a quantidade
        for (int i = 0; i < quantidade; i++) {
            stmt.setInt(1, produtoId);
            stmt.setInt(5, lojaId);
            stmt.setString(2, dataFabrica);
            stmt.setString(3, dataValidade);
            stmt.setInt(4, id);


            int rowsInserted = stmt.executeUpdate();
            totalInsercoes += rowsInserted;
            
            if (totalInsercoes == quantidade) {
            sucesso = true; // A operação foi bem-sucedida
        }
        }
   if (sucesso) {
        response.sendRedirect("sucesso.jsp"); // Redireciona para a página de sucesso
    } else {
         out.print("erro.html");
    }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Fechando a conexão com o banco de dados
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
