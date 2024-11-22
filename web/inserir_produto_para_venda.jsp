<%@ page import="java.sql.*" %>

<%
    // Pega os par�metros do formul�rio de cadastro
    double valorVenda = Double.parseDouble(request.getParameter("valorVenda")); // Corrigido para Double
    int secao_caixa = Integer.parseInt(request.getParameter("sesao")); // Certifique-se de que 'sesao' � o nome correto
    int produtoId = Integer.parseInt(request.getParameter("produto")); // Corrigido para 'produto' (n�o 'porduto')

    String cnpj = request.getParameter("id");
    int Cod = Integer.parseInt(request.getParameter("Cod")); // Pega o par�metro 'Cod' da URL

    // Conex�o com o banco de dados
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

        // Estabelece a conex�o com o banco de dados
        conexao = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);

        // Verifica se o CNPJ j� existe no banco
        String sqlVerificarCNPJ = "SELECT COUNT(*) FROM fornecedor WHERE CNPJ = ?";
        stmtVerificarCNPJ = conexao.prepareStatement(sqlVerificarCNPJ);
        stmtVerificarCNPJ.setString(1, cnpj);
        rs = stmtVerificarCNPJ.executeQuery();

        if (rs.next()) {
            int count = rs.getInt(1);

            if (count > 0) {
                // Se o CNPJ j� existe, retorna uma mensagem de erro
                session.setAttribute("mensagem", "Este CNPJ j� est� cadastrado. Tente novamente.");
                response.sendRedirect("cadastro_empresa.html");
            } else {
                // Se o CNPJ n�o existe, insere os dados na tabela
                String sqlInserir = "INSERT INTO venda (secao_caixa, Produto, valor) VALUES (?, ?, ?)";
                stmtInserir = conexao.prepareStatement(sqlInserir);
                stmtInserir.setInt(1, secao_caixa);
                stmtInserir.setInt(2, produtoId); // A vari�vel 'Produto' foi renomeada para 'produtoId'
                stmtInserir.setDouble(3, valorVenda); // 'valor' foi renomeado para 'valorVenda' e convertido para Double

                int linhasAfetadas = stmtInserir.executeUpdate();

                if (linhasAfetadas > 0) {
                    // Redireciona para a p�gina 'Caixa_aberto.jsp' passando o 'Cod' como par�metro
                    response.sendRedirect("Caixa_aberto.jsp?Cod=" + Cod);
                } else {
                    session.setAttribute("mensagem", "Opera��o n�o-sucedida. Tente novamente.");
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
