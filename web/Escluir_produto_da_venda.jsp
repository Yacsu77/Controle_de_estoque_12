<%-- 
    Document   : excluir_produtos
    Created on : 17 de set. de 2024, 09:31:16
    Author     : evandro.cteruel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%> 
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            
        int id = Integer.parseInt(request.getParameter("id"));
        int secao = Integer.parseInt(request.getParameter("secao"));


            
    String jdbcUrl = "jdbc:mysql://yacsu.mysql.database.azure.com:3306/controle_estoque?zeroDateTimeBehavior=CONVERT_TO_NULL";
    String jdbcUser = "Yacsu77";
    String jdbcPassword = "pedro123@";

            // Declarar as variáveis
            Connection conecta;
            PreparedStatement st;
            int i;
            // Receber o id digitado no formulário
            i = Integer.parseInt(request.getParameter("id"));
            //Conectar com o banco de dados
            Class.forName("com.mysql.cj.jdbc.Driver"); //aponta para a biblioteca JDBC
            conecta = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);
            // Excluir o produto da tabela do banco de dados
            st = conecta.prepareStatement("DELETE from venda WHERE id=?");
            st.setInt(1, id);

            int status = st.executeUpdate(); //Eexecuta o DELETE na tabela do BD
            if(status==1){
            response.sendRedirect("Listar_produtos_para_pagar.jsp?Cod=" + secao );
            } else {
                out.print("Produto não encontrado");
            }            
          %>  
    </body>
</html>
