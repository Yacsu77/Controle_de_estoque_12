<%-- 
    Document   : atualizar_produtos
    Created on : 17 de set. de 2024, 09:31:16
    Author     : evandro.cteruel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%> 
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            // Declarar as variáveis
            
            
    String jdbcUrl = "jdbc:mysql://yacsu.mysql.database.azure.com:3306/controle_estoque?zeroDateTimeBehavior=CONVERT_TO_NULL";
    String jdbcUser = "Yacsu77";
    String jdbcPassword = "pedro123@";
            
            
            Connection conn;
            PreparedStatement st;
    String nomefun = request.getParameter("Funcionario");
    String cpf = request.getParameter("CPF");
    String senha = request.getParameter("Senha");

            int Cod = Integer.parseInt(request.getParameter("Cod"));
            int id_pro = Integer.parseInt(request.getParameter("Id_pro"));

            try {
                //Conectar com o banco de dados
                Class.forName("com.mysql.cj.jdbc.Driver"); //aponta para a biblioteca JDBC
        conn = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);
                // Enviar os dados recebidos para a tabela do banco de dados
                st = conn.prepareStatement("UPDATE funcionario SET nome_funcionario=?, cpf=?, senha=?  WHERE id=?");
                st.setString(1, nomefun);
                st.setString(2, cpf);
                st.setString(3, senha);
                st.setInt(4, Cod);
                st.executeUpdate(); //Eexecuta o UPDATE na tabela do BD
                // Informar o usuário que os dados foram gravados
                out.print("Produto alterado com sucesso");
                response.sendRedirect("Listar_funcionario.jsp?Cod=" + id_pro );
            } catch (SQLException erro) {
               out.print("Erro = " + erro.getMessage());
            }            
        %>  
    </body>
</html>
