import SwiftUI

struct EditFoodView: View {
    @Binding var nameList: [NameClass]
    @Binding var foodItem: FoodClass
    @Binding var categoryList: [CategoryCheck]
    @Binding var total: Double
    
    @State var Photo: String = ""
    @State var Name: String = ""
    @State var Price: Double = 0
    @State var Category: CategoryEnum = CategoryEnum.MainDish
    @State var OldCategory: CategoryEnum = CategoryEnum.MainDish
    
    @State var applyAll1: Bool = true // Apply to those that apply all foods in the same category
    
    @State var refresh = false
    @Environment(\.dismiss) var dismiss
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    func useEffect() -> Void {
        total -= foodItem.Price
        self.Photo = foodItem.Photo
        self.Name = foodItem.Name
        self.Price = foodItem.Price
        self.Category = foodItem.Category
        self.OldCategory = foodItem.Category
    }
    
    func changePhoto() -> Void {
        if(Photo == "🥗") {
            Photo = "🥘"
        } else if (Photo == "🥘") {
            Photo = "🍕"
        } else if (Photo == "🍕") {
            Photo = "🍛"
        } else if (Photo == "🍛") {
            Photo = "🍲"
        } else if (Photo == "🍲") {
            Photo = "🍤"
        } else if (Photo == "🍤") {
            Photo = "🦪"
        } else if (Photo == "🦪") {
            Photo = "🥟"
        } else if (Photo == "🥟") {
            Photo = "🌶️"
        } else if (Photo == "🌶️") {
            Photo = "🥦"
        } else if (Photo == "🥦") {
            Photo = "🧊"
        } else if (Photo == "🧊") {
            Photo = "🍺"
        } else if (Photo == "🍺") {
            Photo = "🥂"
        } else if (Photo == "🥂") {
            Photo = "🍸"
        } else if (Photo == "🍸") {
            Photo = "🍰"
        } else if (Photo == "🍰") {
            Photo = "🍮"
        } else if (Photo == "🍮") {
            Photo = "🥜"
        } else if (Photo == "🥜") {
            Photo = "🍧"
        } else if (Photo == "🍧") {
            Photo = "🍎"
        } else if (Photo == "🍎") {
            Photo = "🍓"
        } else if (Photo == "🍓") {
            Photo = "🍉"
        } else if (Photo == "🍉") {
            Photo = "🍌"
        } else if (Photo == "🍌") {
            Photo = "🍇"
        } else if (Photo == "🍇") {
            Photo = "🫐"
        } else if (Photo == "🫐") {
            Photo = "🥗"
        }
    }
    
    var body: some View {
        ZStack { // ZStack
            Color.init(red: 245/255, green: 245/255, blue: 245/255)
            VStack { // Screen
                VStack { // All top
                    HStack {} // above island
                        .frame(maxWidth: .infinity, maxHeight: 25)
                        .background(.pink)
                    HStack { // Header
                        HStack{} //adjust
                            .frame(width: 40.0, height: 40.0)
                            .padding(.leading, 40)
                        HStack { // middle
                            Text("Add Food")
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                        } // middle
                            .frame(maxWidth: .infinity)
                        HStack{} // adjust / icon
                            .frame(width: 40.0, height: 40.0)
                            .padding(.leading, 40)
                    } // Header
                        .frame(maxWidth: .infinity)
                        .padding(.top, 30)
                        .padding(.bottom, 20)
                        .padding([.leading, .trailing])
                        .background(.pink)
                } // All top
                VStack(spacing: 10) { //form
                    Button (action: {
                        self.changePhoto()
                    }, label: {
                        Text(Photo)
                            .font(.system(size: 80))
                            .frame(maxWidth: 100, maxHeight: 100, alignment: .center)
                            .padding()
                            .background(
                                Circle()
                                    .fill(
                                        .shadow(.inner(color: .gray.opacity(0.5), radius:5, x: 0, y: -5))
                                    )
                            )
                            .cornerRadius(100)
                            .shadow(color: .gray, radius: 5, x: 0, y: 2)
                    })
                    VStack(spacing: 10) { //Name
                        Text("Name")
                            .font(.system(size: 25))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        TextField("Name...", text: self.$Name)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .padding([.top, .bottom], 0)
                            .background(.white)
                            .accentColor(.blue)
                            .cornerRadius(10)
                    } // Name
                        .frame(maxWidth: .infinity, alignment: .leading)
                    VStack(spacing: 10) { //Price
                        Text("Price")
                            .font(.system(size: 25))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        TextField("0", value: self.$Price, formatter: formatter)
                            .keyboardType(.numberPad)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .padding([.top, .bottom], 0)
                            .background(.white)
                            .accentColor(.blue)
                            .cornerRadius(10)
                    } // Price
                        .frame(maxWidth: .infinity, alignment: .leading)
                    VStack(spacing: 10) { // Category
                        Text("Category")
                            .font(.system(size: 25))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Section {
                            Picker("", selection: $Category) {
                                Text("Main Dish").tag(CategoryEnum.MainDish)
                                Text("Side Dish").tag(CategoryEnum.SideDish)
                                Text("Region Food").tag(CategoryEnum.RegionFood)
                                Text("Spicy Food").tag(CategoryEnum.SpicyFood)
                                Text("Vegetarian Food").tag(CategoryEnum.VegeterianFood)
                                Text("Soup").tag(CategoryEnum.Soup)
                                Text("Salad").tag(CategoryEnum.Salad)
                                Text("Drink").tag(CategoryEnum.Drink)
                                Text("Alcohol").tag(CategoryEnum.Alcohol)
                                Text("Dessert").tag(CategoryEnum.Dessert)
                                Text("Category1").tag(CategoryEnum.Category1)
                                Text("Category").tag(CategoryEnum.Category2)
                                Text("Category3").tag(CategoryEnum.Category3)
                            }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .accentColor(.black)
                        }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.top, .bottom], 10)
                            .background(.white)
                            .cornerRadius(10)
                    } // Category
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    if (OldCategory != Category) {
                        ScrollView {
                            VStack(spacing: 5) {
                                Text("It seems like you're changing \(Name)'s Category.")
                                    .font(.system(size: 14))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("*\(Name) will still be seleted by those who")
                                    .font(.system(size: 14))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("had selected \(Name) before this change.")
                                    .font(.system(size: 14))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                HStack { //Apply all 1
                                    Button(action: {
                                        self.applyAll1.toggle()
                                    }, label: {
                                        Image(systemName: !applyAll1 ? "circle" : "checkmark.circle.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 15, height: 15)
                                            .foregroundColor(.red)
                                    })
                                    Text(refresh ? "Apply to those who eat all foods in \(categoryEnumToString(category: Category))" : "Apply to those who eat all foods in \(categoryEnumToString(category: Category))")
                                        .font(.system(size: 15))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                } //Apply all 1
                                    .frame(maxWidth: .infinity, alignment: .topLeading)
                                    .padding(.top, 10)
                            }
                        }
                    }
                    VStack(spacing: 10) { // Save
                        Button(action: {
                            if (OldCategory != Category) {
                                categoryList.forEach { category in
                                    if(category.Name == Category) {
                                        category.count += 1
                                        category.IsCheck = true
                                        if (applyAll1) {
                                            nameList.forEach { name in
                                                if(!name.EatAll) {
                                                    if(name.Categories.contains(categoryEnumToString(category: Category))) {
                                                        name.Foods.append(Name)
                                                    }
                                                }
                                            }
                                        } else {
                                            nameList.forEach { name in
                                                if(name.Categories.contains(categoryEnumToString(category: Category))) {
                                                    name.Categories.remove(at: name.Categories.firstIndex(of: categoryEnumToString(category: Category))!)
                                                }
                                            }
                                        }
                                    } else if(category.Name == OldCategory) {
                                        category.count -= 1
                                        if(category.count == 0) {
                                            category.IsCheck = false
                                            nameList.forEach { name in
                                                if(name.Categories.contains(categoryEnumToString(category: category.Name))) {
                                                    name.Categories.remove(at: name.Categories.firstIndex(of: category.NameS)!)
                                                }
                                            }
                                        }
                                    }
                                }
                                
                            }
                            foodItem = FoodClass(Name: Name, Price: Price, Category: Category, Photo: Photo)
                            total += Price
                            dismiss()
                        }, label: {
                            Text("Save")
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                                .padding([.top, .bottom], 10)
                                .padding([.leading, .trailing], 25)
                                .background(.blue)
                                .foregroundColor(.white)
                                .cornerRadius(15)
                        })
                    } // Save
                        .frame(width: .infinity)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                } //form
                .frame(width: .infinity)
                .frame(maxWidth: .infinity, alignment: .top)
                .padding(.top, 10)
                .padding([.leading, .trailing], 30)
//                .background(.green)
                Spacer()
            } // Screen
        } // ZStack
        .ignoresSafeArea(edges: .top)
        .onAppear() {
            self.useEffect()
        }
    }
}
