<%@ Language="javascript" %>

<% 
    var con = new ActiveXObject("ADODB.Connection"),
        rec = new ActiveXObject("ADODB.RecordSet"); 
    
    //**************Set Connection***********// 
    con.Open("Provider=Microsoft.Jet.OLEDB.4.0;Data Source={directory path}\\App_Data\\Longueuilife.mdb");
    Session("myCon") = con;  
%>

<% //*******Verify Password1 &Password2******// 
    if (Request.QueryString("txtPassword") != Request.QueryString("txtPassword2")){
        Session("errLogin") = "Password1 does not match password2 !"; 
        Response.Redirect("./login.aspx");        
    }
%>

<%
    function verifyEmail(){
        rec.Open("SELECT Email, Passwd from Users where email = '" + Request.QueryString("txtEmail") + "';", con);
        if (rec.EOF){
           rec.Close();  
           return false;
        }
        rec.Close();
        return true;        
    }
%>

<% //****Verify User Email & Update Pwd****//   
   if (!verifyEmail()) {
        Session("errLogin") = "Sorry, this email does not exist.<br />Please create a new account"; 
        Response.Redirect("./login.aspx");
    }
    else {
        con.Execute("UPDATE Users SET passwd = trim('" + Request.QueryString("txtPassword") +"') WHERE trim(email) = trim('" + Request.QueryString("txtEmail") + "');");
        Session("errLogin") = "Your password was reset :)<br />Now, please Log In";  
        Response.Redirect("./login.aspx");
    }
%>
