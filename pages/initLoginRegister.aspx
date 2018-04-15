<%@ Language="javascript" %>

<% 
    var con = new ActiveXObject("ADODB.Connection"),
        rec = new ActiveXObject("ADODB.RecordSet");   
    
    //************Set Connection*************// 
    con.Open("Provider=Microsoft.Jet.OLEDB.4.0;Data Source={directory path}\\App_Data\\Longueuilife.mdb");
    Session("myCon") = con;
%>

<% //*******Verify Password1 &Password2******// 
    if (Request.QueryString("pwd") != Request.QueryString("pwd2")){
        Session("errLogin") = "Password1 does not match password2 !"; 
        Response.Redirect("./login.aspx");
    }
%>

<% //**********Insert New Message************// 
    function verifyUser(){
        rec.Open("SELECT Id, Email, Passwd from Users where email = '" + Request.QueryString("txtEmail") + "' and passwd = '" +
                   Request.QueryString("txtPassword") + "';", con);
        if (rec.EOF){
           rec.Close();  
           return false;
        }
        Session("userID") = rec.Fields["Id"].Value;
        rec.Close();
        return true;        
    }
%>

<%  //**************Verify LOG*************// 
    if (Request.QueryString("l") == 1){
        if (!verifyUser()){
            Session("errLogin") = "Sorry, the member does not exist.<br />Please create a new account"; 
            Response.Redirect("./login.aspx");
        }
        else{
            rec.Open("SELECT FirstName & ' ' & LastName as uname FROM usersinfo ui, users u where u.id = " + Session("userID") + " and u.usersinfo = ui.id", con);
            Session("thisUserName") = rec.Fields['uname'].Value;
            rec.Close();
            Response.Redirect("./account.aspx");
        }
    }
    //***********Verify & Set NEW Account**********// 
    else if (Request.QueryString("l") == 2) {
        if (!verifyUser()){
            con.Execute("INSERT INTO UsersInfo (FirstName, LastName, BirthDate, Gender, Maritalstatus, Looking) VALUES ('" + 
                        Request.QueryString("txtFName") +"','" + Request.QueryString("txtLName") + "','" +
                        Request.QueryString("dateBirth") + "', " + parseInt(Request.QueryString("selGender")) + ", " +
                        parseInt(Request.QueryString("selMaritalStatus")) + ", " + parseInt(Request.QueryString("selLooking")) + ");");

            rec.Open("SELECT Max(id) as [maxid] FROM UsersInfo", con);
            if (!rec.EOF){
                con.Execute("INSERT INTO Users (Email, Passwd, UsersInfo) VALUES ('" + 
                            Request.QueryString("email") +"','" + Request.QueryString("pwd") + "'," +
                            rec.Fields["maxid"].Value + ");");
                rec.Close();
                Session("errLogin") = "The member has been created :)<br />Now, please Log In";  
                Response.Redirect("./login.aspx");
            }
        }
        else
            {
            Session("errLogin") = "Sorry, the member exist.<br />Please Log In"; 
            Response.Redirect("./login.aspx");
        }
    }
%>
