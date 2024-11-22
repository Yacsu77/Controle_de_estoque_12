<%@ page import="java.sql.*" %>
<%
    // Obtendo o ID da empresa do parâmetro

    int Cod = Integer.parseInt(request.getParameter("Cod"));
    
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
        stmt.setInt(1, Cod);
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
    <title>Alterar de Loja</title>
    <link rel="stylesheet" href="cadastro_empesa.css">
</head>
<body>
    <h2>Abrir Caixa</h2>
    <form action="Abrir_caixa.jsp?Cod=<%= Cod %> method="post">
           
        <label for="loja">Loja</label>
        <select id="loja" name="loja" required>
            <option value="">Selecione um gerente</option>
            <%
                // Populando o dropdown com os fornecedores
                if (rs != null) {
                    while (rs.next()) {
                        int loja = rs.getInt("id"); // Altere para o nome correto da coluna
                        String name = rs.getString("nome_loja"); // Altere para o nome correto da coluna
            %>
                        <option value="<%= loja %>"><%= name %></option>
            <%
                    }
                }
            %>
        </select>

        <button type="submit">Abrir Caixa</button>
    </form>

    <%
        // Fechando a conexão com o banco de dados
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    %>
</body>
</html>
