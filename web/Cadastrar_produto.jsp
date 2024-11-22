<%@ page import="java.sql.*" %>

<%
    // Pega os parâmetros do formulário de cadastro
    String nome = request.getParameter("nome_produto");
    int Fornecedor = Integer.parseInt(request.getParameter("cod_forne"));
    double preco = Double.parseDouble(request.getParameter("preco"));
    double velor_venda = Double.parseDouble(request.getParameter("Valor_venda"));

    int cod_empresa = Integer.parseInt(request.getParameter("id"));
    
   String cnpj = request.getParameter("data_validade");
   
   


    // Conexão com o banco de dados
    String jdbcUrl = "jdbc:mysql://yacsu.mysql.database.azure.com:3306/controle_estoque?zeroDateTimeBehavior=CONVERT_TO_NULL";
    String jdbcUser = "Yacsu77";
    String jdbcPassword = "pedro123@";

    Connection conexao = null;
    PreparedStatement stmtVerificarCNPJ = null;
    ResultSet rs = null;
    PreparedStatement stmtInserir = null;

    try {
        // Carrega o driver JDBC
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Estabelece a conexão com o banco de dados
        conexao = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);

        // Verifica se o CNPJ já existe no banco
        String sqlVerificarCNPJ = "SELECT COUNT(*) FROM fornecedor WHERE CNPJ = ?";
        stmtVerificarCNPJ = conexao.prepareStatement(sqlVerificarCNPJ);
        stmtVerificarCNPJ.setString(1, cnpj);
        rs = stmtVerificarCNPJ.executeQuery();

        if (rs.next()) {
            int count = rs.getInt(1);

            if (count > 0) {
                // Se o CNPJ já existe, retorna uma mensagem de erro
                session.setAttribute("mensagem", "Este CNPJ já está cadastrado. Tente novamente.");
                response.sendRedirect("cadastro_empresa.html");
            } else {
                // Se o CNPJ não existe, insere os dados na tabela
                String sqlInserir = "INSERT INTO produto (nome_produto, cod_forne, cod_empresa, preco,Valor_venda) VALUES ( ? , ? , ? , ?,? )";
                stmtInserir = conexao.prepareStatement(sqlInserir);
                stmtInserir.setString(1, nome);
                stmtInserir.setInt(2, Fornecedor);
                stmtInserir.setInt(3, cod_empresa);
                stmtInserir.setDouble(4, preco);
                stmtInserir.setDouble(5, velor_venda);


                int linhasAfetadas = stmtInserir.executeUpdate();

                if (linhasAfetadas > 0) {
        response.sendRedirect("Cadastrar_produto_form.jsp?id=" + cod_empresa);
                } else {
                    session.setAttribute("mensagem", "Operação não-sucedida. Tente novamente.");
                    response.sendRedirect("Cadastro_fornecedor_form.jsp");
                }
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("Erro: " + e.getMessage());
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmtVerificarCNPJ != null) stmtVerificarCNPJ.close();
            if (stmtInserir != null) stmtInserir.close();
            if (conexao != null) conexao.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
