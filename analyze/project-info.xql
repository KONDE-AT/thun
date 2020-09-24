xquery version "3.1";
declare namespace expath="http://expath.org/ns/pkg";
declare namespace repo="http://exist-db.org/xquery/repo";
import module namespace app="http://www.digital-archiv.at/ns/templates" at "../modules/app.xql";
import module namespace config="http://www.digital-archiv.at/ns/config" at "modules/config.xqm";
declare option exist:serialize "method=json media-type=text/javascript content-type=application/json";


let $description := doc(concat($config:app-root, "/repo.xml"))//repo:description/text()
let $authors := normalize-space(string-join(doc(concat($config:app-root, "/repo.xml"))//repo:author//text(), ', '))
let $map := map{
    "title": "Thun Korrespondenz",
    "subtitle": "Die Korrespondenz von Leo von Thun-Hohenstein. Eine digitale Edition",
    "author": "Brigitte Mazohl, Christof Aichner, Tanja Kraler, Peter Andorfer",
    "description": "Die Reformen der Ära Thun-Hohenstein (1849-1861) haben das höhere Bildungssystem und die Universitäten der Habsburger Monarchie massgeblich verändert und die österreichische Bildungslandschaft bis weit ins 20. Jahrhundert hinein geprägt. Das Ziel der Reformen war eine Neuorientierung von Bildung und Wissenschaft gemäss dem Prinzip von Lern- und Lehrfreiheit, dies jedoch unter katholischen Prämissen. Die Universitäten der Monarchie sollten auf ein international konkurrenzfähiges wissenschaftliches Niveau gehoben und gleichzeitig zu staatsbejahenden Anstalten unter katholischen Vorzeichen umgeformt werden. Glaube und Wissenschaft wurden dabei nicht als Gegensatz verstanden. Im Gegenteil, im Zusammenwirken von beiden, so die Hoffnung der Reformer, sollten moderne kritische Wissenschaft und christliche Grundsätze verbunden und die Kräfte von „Volk“ und „geistiger Elite“ miteinander versöhnt werden. Obwohl dieser Versuch der Verbindung von Wissenschaft und Glaube scheiterte, blieb das Thun’sche Reformwerk von grundlegender Bedeutung für die österreichische Bildungs- und Wissen­schaftslandschaft bis in die Zeit der Massenuniversität des späten 20. Jahrhunderts hinein. Zentrale Fragestellungen des Projekts sind das Verhältnis zwischen Kirche, Staat und Wissenschaft, wie es sich in der Korrespondenz des Ministers mit den namhaften Gelehrten, Universitätsprofessoren und Repräsentanten der Religionsgemeinschaften widerspiegelt. Graf Leo von Thun-Hohenstein war ja nicht nur der Minister der Bildungsreform, sondern auch der Minister des Konkordats von 1855, womit der katholischen Kirche massgeblicher Einfluss auf das primäre Bildungssystem im Elementarschulbereich gewährt wurde. Die Quellengrundlage bilden die Briefe aus der Ministerzeit Thun-Hohensteins (Bestand D des Nachlasses Thun-Hohenstein) im tschechischen Staatsarchiv Tetschen, sowie die Gegenbriefe (aus Thun-Hohensteins Feder) in zahlreichen in- und ausländischen Archiven. Die europäische Dimension dieses Quellenkorpus und die zentralen Fragestellungen lassen entscheidende neue Erkenntnisse zur österreichischen Bildungspolitik im 19. Jahrhundert und ihre Einbettung in die internationale Entwicklung erwarten. Das Thun-Hohenstein’sche Universitätsmodell kann dabei als eigenständige Weiterentwicklung der Humboldtschen Universität in den Habsburgischen Ländern gesehen werden.",
    "github": "https://github.com/KONDE-AT/thun",
    "purpose_de": "Ziel von Thun Korrespondenz ist die Publikation von Forschungsdaten.",
    "purpose_en": "The purpose of Thun Korrespondenz is the publication of research data.",
    "app_type": "digital-edition",
    "base_tech": "eXist-db",
    "framework": "Digital Scholarly Editions Base Application"
}
return 
        $map