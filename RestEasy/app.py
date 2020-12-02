from flask import Flask, flash, render_template, redirect, url_for, request, session, abort
import pymysql

app = Flask(__name__)
app.secret_key = b'_5#y2L"F4Q8z\n\xec]/'

db = pymysql.connect("localhost", "root", "root", "resteasy")

@app.route('/')
def home():
    return render_template("main.html")

@app.route('/signup', methods=["GET", "POST"])
def signup():
    msg = ''
    if request.method == "POST":
        attempted_username = request.form['customername']
        attempted_email = request.form['email']
        attempted_password = request.form['password']

        try:
            with db.cursor() as cursor:
                sql = "SELECT customer_email FROM t_customer WHERE customer_email= %s"
                cursor.execute(sql, (attempted_email,))
                result = cursor.fetchone()
                if result:
                    msg="User email already exists!"
                else:
                    sql = "INSERT INTO t_customer(customer_email,customer_name,password) VALUES(%s,%s,%s)"
                    cursor.execute(sql, (attempted_email, attempted_username, attempted_password))
                    db.commit()
                    msg="Sign up successful. Login to order food."
        except Exception as e:
            msg="Error creating customer profile. Please try later."

    return render_template("main.html",msg = msg)

@app.route('/login', methods=["GET", "POST"])
def login():
    msg = ''
    if request.method == "POST":
        attempted_email = request.form['lemail']
        attempted_password = request.form['lpassword']

        if attempted_email == 'admin@resteasy.com' and attempted_password == 'admin':
            session['username'] = 'Admin'
            return render_template("dashboard.html", msg=session['username'])
        else:
            try:
                with db.cursor() as cursor:
                    sql = "SELECT customer_name,customer_email,password FROM t_customer WHERE customer_email= %s AND password = %s"
                    cursor.execute(sql, (attempted_email,attempted_password))
                    result = cursor.fetchone()
                    if result:
                        session['username'] = result[0]
                        #return render_template("alldishes.html",msg = session['username'])
                        return redirect('/alldishes')
                    else:
                        msg="Login attempt failed. Please enter valid login ID and password"
                        return render_template("main.html", msg=msg)
            except Exception as e:
                msg="Error occurred during login. Please try again."
                return render_template("main.html", msg=msg)


@app.route('/logout')
def logout():
    session.pop('username', None)
    return render_template("main.html",msg = "Thank You. Visit Again.")

@app.route('/alldishes')
def alldishes():
    try:
        with db.cursor() as cursor:
            sql = "SELECT * FROM t_vendordish"
            cursor.execute(sql)
            result = cursor.fetchall()
            if result:
                # return render_template("alldishes.html",msg = session['username'])
                return render_template("alldishes.html",msg = session['username'],itemlist = result)

    except Exception as e:
        msg = "Error reading data."
        return render_template("main.html", msg=msg)

@app.route('/alldishesinc')
def alldishessortincreasing():
    try:
        with db.cursor() as cursor:
            sql = "SELECT * FROM t_vendordish ORDER BY price ASC"
            cursor.execute(sql)
            result = cursor.fetchall()
            if result:
                # return render_template("alldishes.html",msg = session['username'])
                return render_template("alldishes.html",msg = session['username'],itemlist = result)

    except Exception as e:
        msg = "Error reading data."
        return render_template("main.html", msg=msg)


@app.route('/alldishesdec')
def alldishessortdecreasing():
    try:
        with db.cursor() as cursor:
            sql = "SELECT * FROM t_vendordish ORDER BY price DESC"
            cursor.execute(sql)
            result = cursor.fetchall()
            if result:
                # return render_template("alldishes.html",msg = session['username'])
                return render_template("alldishes.html",msg = session['username'],itemlist = result)

    except Exception as e:
        msg = "Error reading data."
        return render_template("main.html", msg=msg)

@app.route('/dishes')
def dishes():
    try:
        with db.cursor() as cursor:
            sql = "SELECT * FROM t_dish"
            cursor.execute(sql)
            result = cursor.fetchall()
            if result:
                # return render_template("alldishes.html",msg = session['username'])
                return render_template("dishcalories.html",msg = session['username'],itemlist = result)

    except Exception as e:
        msg = "Error reading data."
        return render_template("main.html", msg=msg)

@app.route('/dishsearch', methods=["GET", "POST"])
def dishsearch():
    if request.method == "POST":
        searchtext = request.form['dishsearch']
        searchtext = "%"+searchtext+"%"
    try:
        with db.cursor() as cursor:
            sql = "SELECT * FROM t_dish where dish_name LIKE %s"
            cursor.execute(sql,searchtext)
            result = cursor.fetchall()
            if result:
                # return render_template("alldishes.html",msg = session['username'])
                return render_template("dishcalories.html",msg = session['username'],itemlist = result)

    except Exception as e:
        msg = "Error reading data."
        return render_template("main.html", msg=msg)

@app.route('/vendors')
def vendors():
    try:
        with db.cursor() as cursor:
            sql = "SELECT * FROM t_vendor"
            cursor.execute(sql)
            result = cursor.fetchall()
            if result:
                return render_template("vendors.html",msg = session['username'],itemlist = result)

    except Exception as e:
        msg = "Error reading data."
        return render_template("main.html", msg=msg)

@app.route('/vendorsearch', methods=["GET", "POST"])
def vendorsearch():
    if request.method == "POST":
        searchtext = request.form['vendorsearch']
        searchtext = "%"+searchtext+"%"
    try:
        with db.cursor() as cursor:
            sql = "SELECT * FROM t_vendor where vendor_name LIKE %s"
            cursor.execute(sql,searchtext)
            result = cursor.fetchall()
            if result:
                # return render_template("alldishes.html",msg = session['username'])
                return render_template("vendors.html",msg = session['username'],itemlist = result)

    except Exception as e:
        msg = "Error reading data."
        return render_template("main.html", msg=msg)

@app.route('/mycart',)
def mycart():
    return render_template("mycart.html",msg = session['username'])




if __name__ == '__main__':
    app.config['ENV'] = 'development'
    app.config['DEBUG'] = True
    app.config['TESTING'] = True

    app.run(debug=True, host='0.0.0.0', port=5000)
