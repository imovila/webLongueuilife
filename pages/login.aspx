<%@  Language="javascript" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Login to Longueuilife</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="../assets/css/main.css" />
    <link rel="stylesheet" href="../assets/css/loginstyle.css">
</head>

<body>

    <!-- Header -->
    <header id="header">
        <a href="../index.html" class="logo"><img src="../images/rencontre.jpg" style="max-width: 70px; max-height: 70px; margin-top:5px" alt="">
        Longueuilife</a>
    </header>

    <div class="panel">
        <h2>LOGIN</h2>

        <form action="initLoginRegister.aspx" method="get">
            <input type="hidden" name="l" value="1" />
            <div class="formset">
                <div class="form-group">
                    <lable class="form-label">Email</lable>
                    <input name="txtEmail" class="form-control" type="email" required="required" value="auroreberiault@teleworm.us"/>
                </div>
                <div class="form-group">
                    <lable class="form-label">Password</lable>
                    <input name="txtPassword" class="form-control" type="password" required="required" value="123456"/>
                </div>
                    <span style = "color: #FF5733"><%=Session("errLogin") %></span>
                    <% Session("errLogin") = "" %>
                <button class="btn">Log in</button>
        </form>
        <a href="./forgotPwd.aspx">Forgot Your Password?</a>
        </div>
        <form class="register-form" action="initLoginRegister.aspx" method="get">
            <input type="hidden" name="l" value="2" />
            <i class="close">×</i>
            <h2>REGISTER</h2>
            <div class="formset">
                <div class="form-group">
                    <lable class="form-label">First Name</lable>
                    <input class="form-control" name="txtFName" type="text" required="required" />
                </div>
                <div class="form-group">
                    <lable class="form-label">Last Name</lable>
                    <input class="form-control" name="txtLName" type="text" required="required"/>
                </div>
                <div class="form-group">
                    <lable class="form-select">Birth Date</lable>
                    <input class="form-control" name="dateBirth" type="date" required="required"/>
                </div>
                <div class="form-group">
                    <lable class="form-select">Gender</lable>
                    <select name="selGender" required="required">
                        <option value="" disabled selected>Select...</option>
                        <option value="1">Woman</option>
                        <option value="2">Man</option>
                    </select>
                </div>
                <div class="form-group">
                    <lable class="form-select">Marital Status</lable>
                    <select name="selMaritalStatus" required="required">
                        <option value="" disabled selected>Select...</option>
                        <option value="1">Married</option>
                        <option value="2">Single</option>
                        <option value="3">Divorced</option>
                        <option value="4">Widow</option>
                    </select>
                </div>
                <div class="form-group">
                    <lable class="form-select">Looking</lable>
                    <select name="selLooking" required="required">
                        <option value="" disabled selected>Select...</option>
                        <option value="1">Woman</option>
                        <option value="2">Man</option>
                    </select>
                </div>
                <div class="form-group">
-                    <lable class="form-label">Email</lable>
                    <input class="form-control" name="email" type="email" required="required"/>
                </div>
                <div class="form-group">
                    <lable class="form-label">Password</lable>
                    <input class="form-control" name="pwd" type="password" required="required"/>
                </div>
                <div class="form-group">
                    <lable class="form-label">Repeat Password</lable>
                    <input class="form-control" name="pwd2" type="password" required="required"/>
                </div>
                 <span style = "color: #FF5733"><%=Session("errLogin") %></span>
                <button class="btn">Create</button>
            </div>
        </form>
    </div>
    <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>

    <script src="../assets/js/login.js"></script>

</body>

</html>
