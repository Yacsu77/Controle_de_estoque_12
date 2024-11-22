<%@ page import="java.sql.*" %>
<%
    // Obtendo o ID da empresa do parâmetro
    int id = Integer.parseInt(request.getParameter("id"));

    // Variáveis para conexão com o banco
    String jdbcUrl = "jdbc:mysql://yacsu.mysql.database.azure.com:3306/controle_estoque?zeroDateTimeBehavior=CONVERT_TO_NULL";
    String jdbcUser = "Yacsu77";
    String jdbcPassword = "pedro123@";

    // Conectando ao banco de dados e obtendo os fornecedores
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);
        
        // Consulta SQL para obter os fornecedores da empresa específica
        String sql = "SELECT * FROM loja WHERE cod_empresa = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id);
        rs = stmt.executeQuery();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastro de Produto</title>
    <link rel="stylesheet" href="cadastro_empesa.css">
</head>
<body>
    <h2>Cadastro de Produto</h2>
    <form action="Listar_produtos_estoque.jsp?Cod=<%= id %> " method="post">
        



        <label for="loja">lojas</label>
        <select id="loja" name="loja" required>
            <option value="">Selecione um fornecedor</option>
            <%
                // Populando o dropdown com os fornecedores
                if (rs != null) {
                    while (rs.next()) {
                        int codForne = rs.getInt("id"); // Altere para o nome correto da coluna
                        String nomeForne = rs.getString("nome_loja"); // Altere para o nome correto da coluna
            %>
                        <option value="<%= codForne %>"><%= nomeForne %></option>
            <%
                    }
                }
            %>
        </select>


        <button type="submit">Listar Produtos</button>
    </form>

    <%
        // Fechando a conexão com o banco de dados
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    %>
</body>
</html>
