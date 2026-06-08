from flask import Flask, render_template

app = Flask(__name__)


@app.route("/")
def root():
    return render_template("linkedout_sara.html")


@app.route("/linkedout/sara-reeves")
def linkedout_sara():
    return render_template("linkedout_sara.html")


@app.route("/linkedout/sara-reeves/views")
def linkedout_sara_views():
    return render_template("linkedout_sara_views.html")


@app.route("/linkedout/alex-hartmann")
def linkedout_alex():
    return render_template("linkedout_alex.html")


@app.route("/linkedout/emma-clarke")
def linkedout_emma():
    return render_template("linkedout_emma.html")


@app.route("/linkedout/james-okafor")
def linkedout_james():
    return render_template("linkedout_james.html")


@app.route("/linkedout/nina-scholz")
def linkedout_nina():
    return render_template("linkedout_nina.html")


@app.route("/github/notifications")
def github_notifications():
    return render_template("github_notifications.html")


@app.route("/github/alex-h")
def github_profile():
    return render_template("github_alex.html")


@app.route("/github/alex-h/threat-intel-notes")
def github_repo():
    return "404 — Repository not found", 404


@app.route("/github/nina-scholz")
def github_nina():
    return render_template("github_nina.html")


@app.route("/github/sara-reeves/pulseloader-analysis")
def github_sara_repo():
    return render_template("github_sara_repo.html")


@app.route("/github/sara-reeves/pulseloader-analysis/watchers")
def github_sara_watchers():
    return render_template("github_sara_watchers.html")


@app.route("/sara-reeves.io")
def personal_website():
    return render_template("personal_website.html")


@app.route("/sara-reeves.io/analytics")
def personal_website_analytics():
    return render_template("personal_website_analytics.html")


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080, debug=False)