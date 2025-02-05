//
//  ViewController.swift
//  Project-27_Core Graphics
//
//  Created by Serhii Prysiazhnyi on 02.12.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var currentDrawType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawRectangle()
        
    }
    
    @IBAction func redrawTapped(_ sender: Any) {
        currentDrawType += 1
        
        if currentDrawType > 7 {
            currentDrawType = 0
        }
        
        switch currentDrawType {
        case 0:
            drawRectangle()
        case 1:
            drawCircle()
        case 2:
            drawCheckerboard()
        case 3:
            drawRotatedSquares()
        case 4:
            drawLines()
        case 5:
            drawImagesAndText()
        case 6:
            drawEmojiSmile()
        case 7:
            drawEmojiStar()
        default:
            break
        }
    }
    
    func drawRectangle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            
            let rectangle = CGRect(x: 5, y: 5, width: 502, height: 502)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = img
    }
    
    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = img
    }
    
    func drawCheckerboard() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            
            for row in 0 ..< 8 {
                for col in 0 ..< 8 {
                    if (row + col) % 2 == 0 {
                        ctx.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
                    }
                }
            }
        }
        
        imageView.image = img
    }
    
    func drawRotatedSquares() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            let rotations = 16
            let amount = Double.pi / Double(rotations)
            
            for _ in 0 ..< rotations {
                ctx.cgContext.rotate(by: CGFloat(amount))
                ctx.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
            }
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        
        imageView.image = img
    }
    
    func drawLines() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            var first = true
            var length: CGFloat = 256
            
            for _ in 0 ..< 256 {
                ctx.cgContext.rotate(by: .pi / 2)
                
                if first {
                    ctx.cgContext.move(to: CGPoint(x: length, y: 50))
                    first = false
                } else {
                    ctx.cgContext.addLine(to: CGPoint(x: length, y: 50))
                }
                
                length *= 0.99
            }
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        
        imageView.image = img
    }
    
    func drawImagesAndText() {
        // 1 Создайте рендерер нужного размера
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            // 2 Определите стиль абзаца, который выравнивает текст по центру
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            // 3 Создайте словарь атрибутов, содержащий этот стиль абзаца, а также шрифт
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 36),
                .paragraphStyle: paragraphStyle
            ]
            
            // 4 Оберните этот словарь атрибутов и строку в экземпляр NSAttributedString
            let string = "The best-laid schemes o'\nmice an' men gang aft agley"
            let attributedString = NSAttributedString(string: string, attributes: attrs)
            
            // 5 Загрузите изображение из проекта и нарисуйте его в контексте
            attributedString.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, context: nil)
            
            let mouse = UIImage(named: "mouse")
            mouse?.draw(at: CGPoint(x: 300, y: 150))
        }
        
        // 6 Обновите вид изображения с готовым результатом
        imageView.image = img
    }
    
    func drawEmojiSmile() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            let context = ctx.cgContext
            
            // 1. Лицо (круг)
            let faceRect = CGRect(x: 56, y: 56, width: 400, height: 400)
            context.setFillColor(UIColor.yellow.cgColor)
            context.fillEllipse(in: faceRect)
            
            // 2. Левый глаз
            let leftEyeRect = CGRect(x: 160, y: 160, width: 50, height: 50)
            context.setFillColor(UIColor.black.cgColor)
            context.fillEllipse(in: leftEyeRect)
            
            // 3. Правый глаз
            let rightEyeRect = CGRect(x: 300, y: 160, width: 50, height: 50)
            context.fillEllipse(in: rightEyeRect)
            
            // 4. Улыбка (дуга)
            context.setStrokeColor(UIColor.red.cgColor)
            context.setLineWidth(10)
            context.addArc(center: CGPoint(x: 256, y: 300),
                           radius: 120,
                           startAngle: 0.2 * .pi,
                           endAngle: 0.8 * .pi,
                           clockwise: false)
            context.strokePath()
        }
        
        imageView.image = img
    }
    
    func drawEmojiStar() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            let context = ctx.cgContext
            
            context.setFillColor(UIColor.yellow.cgColor)
            context.setStrokeColor(UIColor.orange.cgColor)
            context.setLineWidth(5)
            
            // Центр и радиусы
            let center = CGPoint(x: 256, y: 256)
            let radius: CGFloat = 150
            let innerRadius: CGFloat = 60
            let pointsOnStar = 5
            
            var angle = -CGFloat.pi / 2 // Начальный угол
            
            let angleIncrement = CGFloat.pi * 2 / CGFloat(pointsOnStar * 2)
            
            let path = CGMutablePath()
            
            for i in 0..<(pointsOnStar * 2) {
                let isEven = i % 2 == 0
                let distance = isEven ? radius : innerRadius
                
                let x = center.x + cos(angle) * distance
                let y = center.y + sin(angle) * distance
                
                if i == 0 {
                    path.move(to: CGPoint(x: x, y: y))
                } else {
                    path.addLine(to: CGPoint(x: x, y: y))
                }
                
                angle += angleIncrement
            }
            
            path.closeSubpath()
            
            context.addPath(path)
            context.drawPath(using: .fillStroke)
        }
        
        imageView.image = img
    }
}

