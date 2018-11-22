import Foundation

public class Movie {
    public static let childrens = 2
    public static let newRelease = 1
    public static let regular = 0
    
    let title: String
    var priceCode: Int
    
    init(title: String, priceCode: Int) {
        self.title = title
        self.priceCode = priceCode
    }
}

class Rental {
    let movie: Movie
    let daysRented: Int
    
    init(movie: Movie, daysRented: Int) {
        self.movie = movie
        self.daysRented = daysRented
    }
    
    func getCharge() -> Double {
        var result: Double = 0
        
        switch movie.priceCode {
        case Movie.regular:
            result += 2
            if daysRented > 2 {
                result += Double(daysRented - 2) * 1.5
            }
        case Movie.newRelease:
            result += Double(daysRented) * 3
        case Movie.childrens:
            result += 1.5
            if daysRented > 3 {
                result += Double(daysRented - 3) * 1.5
            }
        default:
            break
        }
        
        return result
    }
    
    func getFrequentRentalPoints() -> Int {
        if movie.priceCode == Movie.newRelease && daysRented > 1 {
            return 2
        } else {
            return 1
        }
    }
}

class Customer {
    let name: String
    private var rentals: [Rental]
    
    init(name: String, rentals: [Rental] = []) {
        self.name = name
        self.rentals = rentals
    }
    
    func add(rental: Rental) {
        rentals.append(rental)
    }
    
    var statement: String {
        var totalAmount: Double = 0
        var frequentRenterPoints = 0
        var result = "Rental Records for \(name)\n"
        for rental in rentals {
            
            frequentRenterPoints += rental.getFrequentRentalPoints()
            
            result += "\t\(rental.movie.title)\t\(rental.getCharge())\n"
            totalAmount += rental.getCharge()
        }
        
        result += "Amount owed is \(totalAmount)\n"
        result += "You earned \(frequentRenterPoints) frequent renter points"
        return result
    }
}

let avatar = Movie(title: "Avatar", priceCode: Movie.regular)
let dexter = Movie(title: "Dexter", priceCode: Movie.regular)
let bohemianRapsody = Movie(title: "Bohemian Rapsody", priceCode: Movie.newRelease)
let animals = Movie(title: "Animals", priceCode: Movie.childrens)

let rental1 = Rental(movie: avatar, daysRented: 5)
let rental2 =  Rental(movie: dexter, daysRented: 7)
let rental3 = Rental(movie: bohemianRapsody, daysRented: 2)
let rental4 = Rental(movie: animals, daysRented: 10)

let rentals = [rental1, rental2, rental3, rental4]

let customer = Customer(name: "Mihaita", rentals: rentals)
print(customer.statement)

let statement = """
Rental Records for Mihaita
\tAvatar\t6.5
\tDexter\t9.5
\tBohemian Rapsody\t6.0
\tAnimals\t12.0
Amount owed is 34.0
You earned 5 frequent renter points
"""

print(customer.statement == statement)





