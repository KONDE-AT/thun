xquery version "3.1";
import module namespace app="http://www.digital-archiv.at/ns/templates" at "../modules/app.xql";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare option exist:serialize "method=json media-type=text/javascript";

    for $x at $pos in collection($app:editions)//tei:TEI//tei:back//tei:listPlace//tei:place
        let $url := app:hrefToDoc($x)
        let $label := $x/tei:placeName[1]/text()[1]
        let $relType := "mentioned in"
        let $notBefore := data(root($x)//tei:date[@when][1]/@when[1])[1]
        let $coords := tokenize($x//tei:geo/text(), ' ')
        let $idnos := $x//tei:idno/text()
        let $result := map{
                "label": $label,
                "relType": $relType,
                "noteBefore": $notBefore,
                "lat": $coords[1],
                "lng": $coords[2],
                "idnos": $idnos
        }
        where $coords[1] and $notBefore return
            $result