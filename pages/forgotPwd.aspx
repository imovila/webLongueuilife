<%@  Language="javascript" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Password reset</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="../assets/css/main.css" />
    <link rel="stylesheet" href="../assets/css/loginstyle.css">
</head>

<body>

    <!-- Header -->
    <header id="header">
        <a href="../index.html" class="logo">Longueuilife</a>
    </header>

    <div class="panel">
        <h2>Reset Password</h2>
        <form action="iniNewPwd.aspx" method="get">
            <input type="hidden" name="l" value="1" />
            <div class="formset">
                <div class="form-group">
                    <lable class="form-label">Email</lable>
                    <input name="txtEmail" class="form-control" type="email" required="required" />
                </div>
                <div class="form-group">
                    <lable class="form-label">NEW Password</lable>
                    <input name="txtPassword" class="form-control" type="password" required="required" />
                </div>
                <div class="form-group">
                    <lable class="form-label">Repeat NEW Password</lable>
                    <input class="form-control" name="txtPassword2"  type="password" required="required" />
                </div>
                    <span style = "color: #FF5733"><%=Session("errLogin") %></span>
                <button class="btn">Reset</button>
        </form>
    </div>

    <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>

    <script src="../assets/js/login.js"></script>

</body>

</html>
