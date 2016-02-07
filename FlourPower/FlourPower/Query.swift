//
//  Query.swift
//  FlourPower
//
//  Created by Kelly Robinson on 2/6/16.
//  Copyright © 2016 Kelly Robinson. All rights reserved.
//

import UIKit

public class Query: NSObject {
    
    public enum QueryType: String {
        case PrefixAll = "prefixAll"
        case PrefixLast = "prefixLast"
        case PrefixNone = "prefixNone"
    }
    
    public enum RemoveWordsIfNoResult: String {
        case None = "None"
        case LastWords = "LastWords"
        case FirstWords = "FirstWords"
        case AllOptional = "allOptional"
    }
    
    public enum TypoTolerance: String {
        case Enabled = "true"
        case Disabled = "false"
        case Minimum = "min"
        case Strict = "strict"
    }
    
    public var minWordSizeForApprox1: UInt = 3

    public var minWordSizeForApprox2: UInt = 7

    public var minProximity: UInt = 1

    public var getRankingInfo = false

    public var ignorePlural = false

    public var distinct: UInt = 0

    public var page: UInt = 0

    public var hitsPerPage: UInt = 20

    public var typosOnNumericTokens = true

    public var analytics = true

    public var synonyms = true

    public var replaceSynonyms = true

    public var attributesToHighlight: [String]?

    public var attributesToRetrieve: [String]?

    public var tagFilters: String?

    public var optionalTagFilters: String?

    public var query: String?
    
    public var queryType: QueryType?
    
    public var removeWordsIfNoResult: RemoveWordsIfNoResult?
    
    public var typoTolerance: TypoTolerance?
    
    public var attributesToSnippet: [String]?
    public var filters: [String]?
    
    public var facetFilters: [String]?
    
    public var facetFiltersRaw: String?
    
    public var facets: [String]?
    
    public var optionalWordsMinimumMatched: UInt = 0
    
    public var optionalWords: [String]?
    
    public var restrictSearchableAttributes: [String]?
    
    public var highlightPreTag: String?
    
    public var highlightPostTag: String?
    
    public var analyticsTags: [String]?
    
    public var disableTypoToleranceOnAttributes: [String]?
    
    override public var description: String {
        get { return "Query = \(buildURL())" }
    }
    public func buildURL() -> String {
        var url = [String]()
        if let attributesToRetrieve = attributesToRetrieve {
            url.append(Query.encodeForQuery(attributesToRetrieve, withKey: "attributes"))
        }
        if let attributesToHighlight = attributesToHighlight {
            url.append(Query.encodeForQuery(attributesToHighlight, withKey: "attributesToHighlight"))
        }
        if let attributesToSnippet = attributesToSnippet {
            url.append(Query.encodeForQuery(attributesToSnippet, withKey: "attributesToSnippet"))
        }
        
        if let filters = filters {
            url.append(Query.encodeForQuery(filters, withKey: "filters"))
        }
        
        if let facetFilters = facetFilters {
            let data = try! NSJSONSerialization.dataWithJSONObject(facetFilters, options: NSJSONWritingOptions(rawValue: 0))
            let json = NSString(data: data, encoding: NSUTF8StringEncoding) as! String
            url.append(Query.encodeForQuery(json, withKey: "facetFilters"))
        } else if let facetFiltersRaw = facetFiltersRaw {
            url.append(Query.encodeForQuery(facetFiltersRaw, withKey: "facetFilters"))
        }
        
        if let facets = facets {
            url.append(Query.encodeForQuery(facets, withKey: "facets"))
        }
        if let optionalWords = optionalWords {
            url.append(Query.encodeForQuery(optionalWords, withKey: "optionalWords"))
        }
        if optionalWordsMinimumMatched > 0 {
            url.append(Query.encodeForQuery(optionalWordsMinimumMatched, withKey: "optionalWordsMinimumMatched"))
        }
        if minWordSizeForApprox1 != 3 {
            url.append(Query.encodeForQuery(minWordSizeForApprox1, withKey: "minWordSizefor1Typo"))
        }
        if minWordSizeForApprox2 != 7 {
            url.append(Query.encodeForQuery(minWordSizeForApprox2, withKey: "minWordSizefor2Typos"))
        }
        if ignorePlural {
            url.append(Query.encodeForQuery(ignorePlural, withKey: "ignorePlural"))
        }
        if getRankingInfo {
            url.append(Query.encodeForQuery(getRankingInfo, withKey: "getRankingInfo"))
        }
        if !typosOnNumericTokens { // default True
            url.append(Query.encodeForQuery(typosOnNumericTokens, withKey: "allowTyposOnNumericTokens"))
        }
        if let typoTolerance = typoTolerance {
            url.append(Query.encodeForQuery(typoTolerance.rawValue, withKey: "typoTolerance"))
        }
        if distinct > 0 {
            url.append(Query.encodeForQuery(distinct, withKey: "distinct"))
        }
        if !analytics { // default True
            url.append(Query.encodeForQuery(analytics, withKey: "analytics"))
        }
        if !synonyms { // default True
            url.append(Query.encodeForQuery(synonyms, withKey: "synonyms"))
        }
        if !replaceSynonyms { // default True
            url.append(Query.encodeForQuery(replaceSynonyms, withKey: "replaceSynonymsInHighlight"))
        }
        if page > 0 {
            url.append(Query.encodeForQuery(page, withKey: "page"))
        }
        if hitsPerPage != 20 && hitsPerPage > 0 {
            url.append(Query.encodeForQuery(hitsPerPage, withKey: "hitsPerPage"))
        }
        if minProximity > 1 {
            url.append(Query.encodeForQuery(minProximity, withKey: "minProximity"))
        }
        if let queryType = queryType {
            url.append(Query.encodeForQuery(queryType.rawValue, withKey: "queryType"))
        }
        if let removeWordsIfNoResult = removeWordsIfNoResult {
            url.append(Query.encodeForQuery(removeWordsIfNoResult.rawValue, withKey: "removeWordsIfNoResult"))
        }
        if let tagFilters = tagFilters {
            url.append(Query.encodeForQuery(tagFilters, withKey: "tagFilters"))
        }
        if let optionalTagFilters = optionalTagFilters {
            url.append(Query.encodeForQuery(optionalTagFilters, withKey: "optionalTagFilters"))
        }
        
        if let highlightPreTag = highlightPreTag, highlightPostTag = highlightPostTag {
            url.append(Query.encodeForQuery(highlightPreTag, withKey: "highlightPreTag"))
            url.append(Query.encodeForQuery(highlightPostTag, withKey: "highlightPostTag"))
        }
        if let disableTypoToleranceOnAttributes = disableTypoToleranceOnAttributes {
            url.append(Query.encodeForQuery(disableTypoToleranceOnAttributes, withKey: "disableTypoToleranceOnAttributes"))
        }
        
     
        
        return url.joinWithSeparator("&")
    }

    
    class func encodeForQuery<T>(element: T, withKey key: String) -> String {
        switch element {
        case let element as [String]:
            return "\(key)=" + (element.map { $0.urlEncode() }).joinWithSeparator(",")
        case let element as String:
            return "\(key)=\(element.urlEncode())"
        default:
            return "\(key)=\(element)"
        }
    }
}

extension String {
    /// Return URL encoded version of the string
    func urlEncode() -> String {
        let customAllowedSet = NSCharacterSet(charactersInString: "!*'();:@&=+$,/?%#[]").invertedSet
        return stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)!
    }
}
