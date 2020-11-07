//
//  UIColor.swift
//  EZPokemon
//
//  Created by Luca Celiento on 03/11/2020.
//

import UIKit

extension UIColor {
    
    static func from(color: Color) -> UIColor {
        switch color.name {
        case "black": return .black
        case "blue": return .systemBlue
        case "brown": return .brown
        case "gray": return .systemGray
        case "green": return .systemGreen
        case "pink": return .systemPink
        case "purple": return .systemPurple
        case "red": return .systemRed
        case "white": return .white
        case "yellow": return .systemYellow
        default: return UIColor()
        }
    }
    
    static func from(type: PokemonType) -> UIColor {
        switch type.type.name {
        case "normal": return .systemGray
        case "fighting": return .magenta
        case "flying": return .cyan
        case "poison": return .systemPurple
        case "ground": return .systemOrange
        case "rock": return .brown
        case "bug": return .systemGreen
        case "ghost": return .systemBlue
        case "steel": return .systemBlue
        case "fire": return .systemOrange
        case "water": return .cyan
        case "grass": return .systemGreen
        case "electric": return .systemYellow
        case "psychic": return .systemPurple
        case "ice": return .cyan
        case "dragon": return .systemBlue
        case "dark": return .black
        case "fairy": return .systemPink
        case "unknown": return .systemGray
        case "shadow": return .systemPurple
        default: return UIColor()
        }
    }
    
    var isLight: Bool {
        // algorithm from: http://www.w3.org/WAI/ER/WD-AERT/#color-contrast
        let components = self.cgColor.components
        guard self.cgColor.numberOfComponents >= 3 else { return true }
        let red = components?[0] ?? 0
        let green = components?[1] ?? 0
        let blue = components?[2] ?? 0
        let brightness = ((red * 299) + (green * 587) + (blue * 114)) / 1000
        
        return brightness >= 0.5
    }
}
