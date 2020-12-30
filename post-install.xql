xquery version "3.0";
import module namespace util   = "http://exist-db.org/xquery/util";

import module namespace config="http://www.digital-archiv.at/ns/config" at "modules/config.xqm";
import module namespace enrich="http://www.digital-archiv.at/ns/enrich" at "modules/enrich.xql";


(: grant general execution rights to all scripts in analyze and modules collection :)
for $resource in xmldb:get-child-resources(xs:anyURI($config:app-root||"/analyze/"))
    return sm:chmod(xs:anyURI($config:app-root||'/analyze/'||$resource), "rwxrwxr-x"),

for $resource in xmldb:get-child-resources(xs:anyURI($config:app-root||"/modules/"))
    return sm:chmod(xs:anyURI($config:app-root||'/modules/'||$resource), "rwxrwxr-x"),

for $resource in xmldb:get-child-resources(xs:anyURI($config:app-root||"/ac/"))
    return sm:chmod(xs:anyURI($config:app-root||'/ac/'||$resource), "rwxrwxr-x"),
(: 
util:log("info", "adding xml-ids"),
enrich:add_base_and_xmlid('https://id.acdh.oeaw.ac.at/thun/', 'editions'), :)

util:log("info", "adding mentions to index-files"),
enrich:mentions('editions')