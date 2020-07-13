library(httr)
#helps 
install.packages("httpuv")
library(httpuv)
install.packages("rjson")
library(rjson)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at
#    https://github.com/settings/developers. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url

#hint reset client secret
myapp <- oauth_app("github",
                   "0dce494b05f9b91684a0",
                   secret = "63a9a2736fadbe379e47813edcd805ef7aec77d9"
)
# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
output <-content(req)
class(output)
length(output)
#Note output is a list class need to convert to dataframe by converting to Json first

# OR:
req <- with_config(gtoken, GET("https://api.github.com/users/jtleek/datasharing"))
stop_for_status(req)
content(req)

json2=jsonlite::fromJSON(toJSON(output))
names(json2)

json2[json2$name=="datasharing",c("created_at")]


datashare <- which(sapply(output, FUN=function(X) "datasharing" %in% X))
datashare
list(output[[19]]$name, output[[19]]$created_at)