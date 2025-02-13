import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

func fetchBBCNewsRSSFeed() {
    let session = URLSession.shared
    let url = URL(string: "http://feeds.bbci.co.uk/news/rss.xml")!
    let dataTask = session.dataTask(with: url) { (data, response, error) in
        guard let data = data, error == nil else {
            print(error ?? "Unexpected response")
            return
        }
        let parser = XMLParser(data: data)
        let builder = RSSNewsArticleBuilder()
        parser.delegate = builder
        parser.parse()
    }
    dataTask.resume()
}

struct NewsArticle {
    let title: String
    let url: URL
}

class RSSNewsArticleBuilder: NSObject, XMLParserDelegate {
    var inItem = false
    var inTitle = false
    var inLink = false
    var titleData: Data?
    var linkString: String?
    
    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {
        switch elementName {
        case "item":
            inItem = true
        case "title":
            inTitle = true
            titleData = Data()
        case "link":
            inLink = true
            linkString = ""
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser,
                didEndElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?) {
        switch elementName {
        case "item":
            inItem = false
            guard let titleData = titleData,
                  let titleString = String(data: titleData, encoding: .utf8),
                  let linkString = linkString,
                  let link = URL(string: linkString)
            else {
                break
            }
            print("Title: \(titleString)")
            print("Link: \(link)")
        case "title":
            inTitle = false
        case "link":
            inLink = false
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        if inTitle {
            titleData?.append(CDATABlock)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        print("parseFoundCharacters: \(string)")
        if inLink {
            linkString?.append(string)
        }
    }
}

fetchBBCNewsRSSFeed()
