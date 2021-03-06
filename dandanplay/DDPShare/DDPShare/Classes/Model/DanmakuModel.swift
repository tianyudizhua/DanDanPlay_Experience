//
//  DanmakuModel.swift
//  DanDanPlayExperience
//
//  Created by JimHuang on 2020/2/2.
//  Copyright © 2020 JimHuang. All rights reserved.
//

import HandyJSON

#if os(iOS)
typealias DanmakuColor = UIColor
#else
typealias DanmakuColor = NSColor
#endif

open class DanmakuModel: BaseModel {
    public enum Mode: Int, HandyJSONEnum {
        case normal = 1
        case bottom = 4
        case top = 5
    }
    
    open var mode = Mode.normal
    open var time: TimeInterval = 0
    
    open var color = DanmakuColor.white
    open var message = ""
    open var id = ""
    private var p: [String : String]?
    
    override open func mapping(mapper: HelpingMapper) {
        mapper <<<
            p <-- TransformOf<[String : String], String>(fromJSON: { (rawString) -> [String : String]? in
                
                if let parameter = rawString?.components(separatedBy: ",") {
                    var dic = [String : String]()
                    
                    if parameter.count > 0 {
                        dic["Time"] = parameter[0]
                    }
                    
                    if parameter.count > 1 {
                        dic["Mode"] = parameter[1]
                    }
                    
                    if parameter.count > 2 {
                        dic["Color"] = parameter[2]
                    }
                    
                    if parameter.count > 3 {
                        dic["UId"] = parameter[3]
                    }
                    
                    return dic
                }
                return nil
            }, toJSON: { (value) -> String? in
                return "\(self.time),\(self.mode.rawValue),\(self.color),\(self.id)"
            })
        
        mapper <<<
            time <-- "Time"
        
        mapper <<<
            mode <-- "Mode"
        
        mapper <<<
            color <-- ("Color", TransformOf<DanmakuColor, Int>(fromJSON: { (rawValue: Int?) -> DanmakuColor? in
                return DanmakuColor(rgb: rawValue ?? 0)
            }, toJSON: { (color: DanmakuColor?) -> Int in
                if let color = color {
                    return color.rgbValue
                }
                return 0
            }))
        
        mapper <<<
            message <-- ["Message", "m"]
        
        mapper <<<
            id <-- ["CId", "cid"]
    }
    
    override open func didFinishMapping() {
        if let p = self.p {
            self.time = Double(p["Time"] ?? "0") ?? 0
            let modeRawValue = Int(p["Mode"] ?? "\(Mode.normal.rawValue)")!
            self.mode = Mode(rawValue: modeRawValue) ?? .normal
            self.color = DanmakuColor(rgb: Int(p["Color"] ?? "0") ?? 0)
            self.id = p["UId"] ?? ""
            
            self.p = nil
        }
    }
}

open class DanmakuCollectionModel: BaseCollectionModel<DanmakuModel> {
    open var count = 0
    
    override open func mapping(mapper: HelpingMapper) {
        mapper <<<
            collection <-- "comments"
    }
}

public extension DanmakuColor {
    convenience init(rgb rgbValue: Int) {
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                     green: CGFloat((rgbValue & 0xFF00) >> 8) / 255.0,
                     blue: CGFloat((rgbValue & 0xFF)) / 255.0,
                     alpha: 1)
    }
    
    var rgbValue: Int {
        let r = self.redComponent * 255 * 256 * 256
        let b = self.blueComponent * 255 * 256
        let g = self.greenComponent * 255
        
        return Int(r + g + b)
    }
}
