//
//  Contact.swift
//  PhoneBook
//
//  Created by Дарья Хомякова on 12.11.2019.
//  Copyright © 2019 Дарья Хомякова. All rights reserved.
//

import UIKit

class Contact{
    init(name: String, surname: String?, number: String, photo: UIImage?){
        self.name = name
        self.surname = surname
        self.number = number
        self.photo = photo
    }
    
    var name: String
    var surname: String?
    var number: String
    var photo: UIImage?
    
}
