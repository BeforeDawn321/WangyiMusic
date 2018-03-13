//
//  Extention.swift
//  WangyiMusicPlayer
//
//  Created by yuting jiang on 2018/2/11.
//  Copyright © 2018年 yuting jiang. All rights reserved.
//

import AVFoundation
import Foundation
import UIKit

extension UIButton {
    func setImage(image: UIImage?, inFrame frame: CGRect?, forState state: UIControlState) {
        self.setImage(image, for: state)
        if let frame = frame {
            self.imageEdgeInsets = UIEdgeInsets(
                top: frame.minY - self.frame.minY,
                left: frame.minX - self.frame.minX,
                bottom: self.frame.maxY - frame.maxY,
                right: self.frame.maxX - frame.maxX
            )
        }
    }
}

extension UIImageView {
    func rotate360Degree() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z") // 让其在z轴旋转
        rotationAnimation.toValue = NSNumber(value: Double.pi * 2.0) // 旋转角度
        rotationAnimation.duration = 30 // 旋转周期
        
        rotationAnimation.isCumulative = true // 旋转累加角度
        rotationAnimation.repeatCount = 100000 // 旋转次数
        rotationAnimation.isRemovedOnCompletion = false
        layer.add(rotationAnimation, forKey: "rotationAnimation")

    }
    
    func rotate90Degree() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z") // 让其在z轴旋转
        rotationAnimation.toValue = NSNumber(value: Double.pi * (0.2)) // 旋转角度
        rotationAnimation.duration = 2 // 旋转周期
        
        rotationAnimation.isCumulative = true // 旋转累加角度
        rotationAnimation.repeatCount = 1 // 旋转次数
        rotationAnimation.isRemovedOnCompletion = false
        layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    func rotateminus90Degree() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z") // 让其在z轴旋转
        rotationAnimation.toValue = NSNumber(value: Double.pi * (-0.2)) // 旋转角度
        rotationAnimation.duration = 2 // 旋转周期
        
        rotationAnimation.isCumulative = true // 旋转累加角度
        rotationAnimation.repeatCount = 1 // 旋转次数
        rotationAnimation.isRemovedOnCompletion = false
        layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    // 停止旋转
    func stopRotate() {
        layer.removeAllAnimations()
    }
}

//MARK: 设置图片大小
extension UIImage {
    func reSizeImage(reSize: CGSize) -> UIImage {
        //UIGraphicsBeginImageContext(reSize);
        UIGraphicsBeginImageContextWithOptions(reSize, false, UIScreen.main.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height))
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return reSizeImage
    }
    
    func setCircle() -> UIImage {
        let dia = min(self.size.width, self.size.height)
        let ouputRect = CGRect(x: 0, y: 0, width: dia, height: dia)
        UIGraphicsBeginImageContextWithOptions(ouputRect.size, false, 0)
        
        let context = UIGraphicsGetCurrentContext()
        context?.addEllipse(in: ouputRect)
        context?.clip()
        
        self.draw(in: CGRect(x: (dia - self.size.width)/2, y: (dia - self.size.height)/2, width: self.size.width, height: self.size.height))
        
        let maskedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return  maskedImage
    }
}

extension String {
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    
    //将编码后的url转换回原始的url
    func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
}

extension UIView {
    public var x: CGFloat{
        get{
            return self.frame.origin.x
        }
        set{
            var r = self.frame
            r.origin.x = newValue
            self.frame = r
        }
    }
    
    public var y: CGFloat{
        get{
            return self.frame.origin.y
        }
        set{
            var r = self.frame
            r.origin.y = newValue
            self.frame = r
        }
    }
    /// 右边界的x值
    public var rightX: CGFloat{
        get{
            return self.x + self.width
        }
        set{
            var r = self.frame
            r.origin.x = newValue - frame.size.width
            self.frame = r
        }
    }
    /// 下边界的y值
    public var bottomY: CGFloat{
        get{
            return self.y + self.height
        }
        set{
            var r = self.frame
            r.origin.y = newValue - frame.size.height
            self.frame = r
        }
    }
    
    public var centerX : CGFloat{
        get{
            return self.center.x
        }
        set{
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }
    
    public var centerY : CGFloat{
        get{
            return self.center.y
        }
        set{
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
    }
    
    public var width: CGFloat{
        get{
            return self.frame.size.width
        }
        set{
            var r = self.frame
            r.size.width = newValue
            self.frame = r
        }
    }
    public var height: CGFloat{
        get{
            return self.frame.size.height
        }
        set{
            var r = self.frame
            r.size.height = newValue
            self.frame = r
        }
    }
    
    
    public var origin: CGPoint{
        get{
            return self.frame.origin
        }
        set{
            self.x = newValue.x
            self.y = newValue.y
        }
    }
    
    public var size: CGSize{
        get{
            return self.frame.size
        }
        set{
            self.width = newValue.width
            self.height = newValue.height
        }
    }

    func corner(byRoundingCorners corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
}
