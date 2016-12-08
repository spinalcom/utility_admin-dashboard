from concat_js import *


models = []
views = []
stylesheets = []

for p in os.listdir( "modules" ):
    for m in os.listdir("modules/" + p):
        if m == "models":
            models.append("gen/" + m + "/" + p + ".js")
            concat_js( "modules/" + p + "/" + m, "gen/" + m + "/" + p + ".js", "gen/stylesheets/" + p + ".css" )

        elif m == "views":
            views.append("gen/" + m + "/" + p + ".js")
            concat_js( "modules/" + p + "/" + m, "gen/" + m + "/" + p + ".js", "gen/stylesheets/" + p + ".css" )

        elif m == "stylesheets":
            stylesheets.append("gen/" + m + "/" + p + ".css")
            concat_js( "modules/" + p + "/" + m, "gen/" + m + "/" + p + ".js", "gen/stylesheets/" + p + ".css" )

exec_cmd( "echo > admin.models.js " )
exec_cmd( "echo > admin.views.js " )
exec_cmd( "echo > admin.stylesheets.css " )

for m in sorted(models):
    exec_cmd( "cat admin.models.js " + m + " > admin.models_tmp.js" )
    exec_cmd( "mv admin.models_tmp.js admin.models.js" )
for v in sorted(views):
    exec_cmd( "cat admin.views.js " + v + " > admin.views_tmp.js" )
    exec_cmd( "mv admin.views_tmp.js admin.views.js" )
for s in sorted(stylesheets):
    exec_cmd( "cat admin.stylesheets.css " + s + " > admin.stylesheets_tmp.css" )
    exec_cmd( "mv admin.stylesheets_tmp.css admin.stylesheets.css" )