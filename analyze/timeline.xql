xquery version "3.0";
declare namespace functx = "http://www.functx.com";
import module namespace app="http://www.digital-archiv.at/ns/templates" at "../modules/app.xql";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare option exist:serialize "method=json media-type=text/javascript";

let $data := <data>{
    for $x at $pos in collection($app:editions)//tei:correspDesc[.//@when-iso]
    let $sender := string-join($x//tei:correspAction[@type='sent']/tei:rs[@type='person']/text(), ' ')
    let $backlink := app:hrefToDoc($x)
    let $receiver := string-join($x//tei:correspAction[@type='received']/tei:rs[@type='person']/text(), ' ')
    let $content := if ($receiver) 
        then $sender||' wrote to '||$receiver
        else $sender
    let $date := data($x//@when-iso[1])
    let $year := year-from-date(xs:date($date))
    let $month := month-from-date(xs:date($date))
    let $day := day-from-date(xs:date($date))
    return 
        <item>
            <event_id>{$pos}</event_id>
            <sender>{$sender}</sender>
            {if ($receiver) then <receiver>{$receiver}</receiver> else ()}
            <content>{$content}</content>
            <backlink>{$backlink}</backlink>
            <start>{$date}</start>
            <date>({$year},{$month},{$day})</date>
        </item>
}</data>

return $data