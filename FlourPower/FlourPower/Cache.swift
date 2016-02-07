//
//  Cache.swift
//  FlourPower
//
//  Created by Kelly Robinson on 2/6/16.
//  Copyright © 2016 Kelly Robinson. All rights reserved.
//


import Foundation

class ExpiringCacheItem {
    let expiringCacheItemDate: NSDate
    let content: [String: AnyObject]
    
    init(content: [String: AnyObject]) {
        self.content = content
        self.expiringCacheItemDate = NSDate()
    }
}

class ExpiringCache {
    private let cache = NSCache()
    private let expiringTimeInterval: NSTimeInterval
    
    private var cacheKeys = [String]()
    private var timer: NSTimer? = nil
    
    init(expiringTimeInterval: NSTimeInterval) {
        self.expiringTimeInterval = expiringTimeInterval
        
        // Garbage collector like, for the expired cache
        timer = NSTimer(timeInterval: 2 * expiringTimeInterval, target: self, selector: Selector("clearExpiredCache"), userInfo: nil, repeats: true)
        timer!.tolerance = expiringTimeInterval * 0.5
        NSRunLoop.mainRunLoop().addTimer(timer!, forMode: NSDefaultRunLoopMode)
    }
    
    deinit {
        timer!.invalidate()
    }
    
    func objectForKey(key: String) -> [String: AnyObject]? {
        if let object = cache.objectForKey(key) as? ExpiringCacheItem {
            let timeSinceCache = abs(object.expiringCacheItemDate.timeIntervalSinceNow)
            if timeSinceCache > expiringTimeInterval {
                cache.removeObjectForKey(key)
            } else {
                return object.content
            }
        }
        
        return nil
    }
    
    func setObject(obj: [String: AnyObject], forKey key: String) {
        cache.setObject(ExpiringCacheItem(content: obj), forKey: key)
        cacheKeys.append(key)
    }
    
    func clearCache() {
        cache.removeAllObjects()
        cacheKeys.removeAll(keepCapacity: true)
    }
    
    @objc func clearExpiredCache() {
        var tmp = [String]()
        
        for key in cacheKeys {
            if let object = cache.objectForKey(key) as? ExpiringCacheItem {
                let timeSinceCache = abs(object.expiringCacheItemDate.timeIntervalSinceNow)
                if timeSinceCache > expiringTimeInterval {
                    cache.removeObjectForKey(key)
                } else {
                    tmp.append(key)
                }
            }
        }
        
        cacheKeys = tmp
    }
}