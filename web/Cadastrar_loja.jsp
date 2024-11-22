<%@ page import="java.sql.*" %>

<%
    String nome = request.getParameter("nome_loja");
    int gerente = Integer.parseInt(request.getParameter("cod_gen"));
    int cod_empresa = Integer.parseInt(request.getParameter("id"));
    String cnpj = request.getParameter("cnpj");

    String jdbcUrl = "jdbc:mysql://yacsu.mysql.database.azure.com:3306/controle_estoque?zeroDateTimeBehavior=CONVERT_TO_NULL";
    String jdbcUser = "Yacsu77";
    String jdbcPassword = "pedro123@";

    Connection conexao = null;
    PreparedStatement stmtVerificarCNPJ = null;
    ResultSet rs = null;
    PreparedStatement stmtInserir = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conexao = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);

        String sqlVerificarCNPJ = "SELECT COUNT(*) FROM gerente WHERE cpf = ?";
        stmtVerificarCNPJ = conexao.prepareStatement(sqlVerificarCNPJ);
        stmtVerificarCNPJ.setString(1, cnpj);
        rs = stmtVerificarCNPJ.executeQuery();

        if (rs.next() && rs.getInt(1) == 0) {
            String sqlInserir = "INSERT INTO loja (nome_loja, gerente, cod_empresa) VALUES (?, ?, ?)";
            stmtInserir = conexao.prepareStatement(sqlInserir);
            stmtInserir.setString(1, nome);
            stmtInserir.setInt(2, gerente);
            stmtInserir.setInt(3, cod_empresa);

            if (stmtInserir.executeUpdate() > 0) {
                response.sendRedirect("Cadastrar_produto_form.jsp?id=" + cod_empresa);
            } else {
                session.setAttribute("mensagem", "Operação não-sucedida. Tente novamente.");
                response.sendRedirect("Cadastro_fornecedor_form.jsp");
            }
        } else {
            session.setAttribute("mensagem", "Este CNPJ já está cadastrado. Tente novamente.");
            response.sendRedirect("cadastro_empresa.html");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Erro: " + e.getMessage());
    } finally {
        if (rs != null) rs.close();
        if (stmtVerificarCNPJ != null) stmtVerificarCNPJ.close();
        if (stmtInserir != null) stmtInserir.close();
        if (conexao != null) conexao.close();
    }
%>
