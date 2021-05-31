<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>

<%
	Class.forName("com.mysql.jdbc.Driver");
	
	Connection conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/cadastro?user=root");
	
	String acao = request.getParameter("acao");
	
	if(acao == null){
		acao = "listaPessoas";
	}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" href="css/style.csss">
	<title>Cadastro</title>
</head>
<body>
	<form action="#" method="post">
		
		<%
		if(acao.equals("cadastrar")){
			String pess_nome = request.getParameter("pess_nome");
			String pess_nasc = request.getParameter("pess_nasc");
			
			if(!pess_nome.equals("") && !pess_nasc.equals("")){
				String sql = "INSERT INTO pessoas(pess_nome, pess_nasc) VALUES(?,?)";
				
				PreparedStatement start = (PreparedStatement) conn.prepareStatement(sql);
				
				start.setString(1, pess_nome);
				start.setString(2, pess_nasc);
				
				start.execute();
				
				//out.println("<br> Pessoa "+pess_nome+" Cadastrada</br>");
				
				acao = "listaPessoas";
			}else{
				acao = "novoCadastro";
				
				out.println("<h1>Preecha todos os campos!</h1>");
			}
		}
		
		if(acao.equals("novoCadastro")){
			
		%>
		
		<fieldset>
			<legend>Formulario</legend>
			<label>Nome:</label>
				<input type="text" name="pess_nome" class="campo_nome"/>
				<br>
			<label class="nasc">Nascimento:</label>
				<input type="date" name="pess_nasc" class="campo_nasc""/>
				<br>
			
			<button type="submit" name="acao" value="listaPessoas" class="btn_voltar">Voltar</button>
			<button type="submit" name="acao" value="cadastrar" class="btn_salvar">Salvar</button>
			
		</fieldset>
		
		<% } else if(acao.equals("listaPessoas")){%>
		<fieldset>
			<h2>Lista das Pessoas Cadastradas</h2>
			
			<table border="2">
				<thead>
					<tr>
						<th>Codigo</th>
						<th>Nome</th>
						<th>Data de nascimento</th>
					</tr>
				</thead>
				<tbody>
					<%
						Statement s = conn.createStatement();
						ResultSet res = s.executeQuery("SELECT * FROM pessoas");
						
						while(res.next()){
							out.print("<tr>");
							
							out.print("<td>"+res.getString("pess_codi")+"</td>");
							out.print("<td>"+res.getString("pess_nome")+"</td>");
							out.print("<td>"+res.getString("pess_nasc")+"</td>");
							
							out.print("</tr>");
						}
						
					%>
				</tbody>
			</table>
			
			<button type="submit" name="acao" value="novoCadastro" class="cadastrar">Novo Cadastro</button>
		</fieldset>
		
		<% } %>
	</form>
</body>
</html>