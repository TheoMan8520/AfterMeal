import SwiftUI

struct NameListView: View {
    @Binding var nameList: [NameClass]
    @Binding var foodList: [FoodClass]
    @Binding var groupList: [GroupCheck]
    
    @State var editIsOn = false
    @State var deleteIsOn = false
    @State var refresh: Bool = false
    
    func uncheckGroup(groupItem: GroupCheck) -> Void {
        groupList.forEach { group in
            if(group.Name == groupItem.Name) {
                group.count -= 1
                if (group.count == 0) {
                    group.IsCheck = false
                }
            }
        }
    }
    
    var body: some View {
        NavigationStack { // NavigationView
            ZStack { // ZStack
                Color.init(red: 245/255, green: 245/255, blue: 245/255)
                VStack { // Screen
                    VStack(spacing: 0) { // All top
                        HStack {} // above island
                            .frame(maxWidth: .infinity, maxHeight: 25)
                            .background(.blue)
                        HStack { // Header
                            HStack{} //adjust
                                .frame(width: 40.0, height: 40.0, alignment: .trailing)
                                .padding(.leading, 20)
                            HStack { // middle
                                Text("Name List")
                                    .font(.system(size: 30))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                            } // middle
                                .frame(maxWidth: .infinity)
                            HStack{ // adjust / icon
                                NavigationLink(destination: AddNameView(nameList: self.$nameList, groupList: self.$groupList, foodList: self.foodList)) {
                                    Image(systemName: "plus.circle")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .foregroundColor(Color.white)
                                        .frame(width: 30.0, height: 30.0)
                                }
                                .onAppear(
                                )
                            } // adjust / icon
                                .frame(width: 40.0, height: 40.0, alignment: .leading)
                                .padding(.trailing, 20)
                        } // Header
                            .frame(maxWidth: .infinity)
                            .padding(.top, 30)
                            .padding(.bottom, 15)
                            .padding([.leading, .trailing])
                            .background(.blue)
                    } // All top
                    VStack(spacing: 10) { // Body
                        if (nameList == []) {
                            VStack {
                                Text("No Name added")
                            }
                        } else { //else
                            ScrollView { // ScrollView
                                ForEach(groupList, id:\.self) { group in //for group in
                                    if(group.IsCheck) { // if group.IsCheck
                                        VStack {// Group
                                            HStack { // Group Header
                                                Text(refresh ? group.NameS : group.NameS)
                                                    .font(.system(size: 25))
                                                    .fontWeight(.semibold)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                            } // Group Header
                                            VStack { //Names
                                                ForEach(self.$nameList, id:\.self) { name in // for Name in group
                                                    if(groupEnumToString(group: name.wrappedValue.Group) == group.NameS) { // if
                                                        HStack { // NameItem
                                                            Text(name.wrappedValue.Photo)
                                                                .font(.system(size: 45))
                                                                .frame(width: 55, height: 55)
                                                            VStack(spacing: 5) {
                                                                Text(refresh ? "\(name.wrappedValue.Name)" : "\(name.wrappedValue.Name)")
                                                                    .font(.system(size: 15))
                                                                    .fontWeight(.semibold)
                                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                                HStack(spacing: 3) { //Apply all
                                                                    Image(systemName: name.wrappedValue.EatAll ? "checkmark.circle.fill" : "circle")
                                                                        .resizable()
                                                                        .aspectRatio(contentMode: .fit)
                                                                        .frame(width: 15, height: 15)
                                                                        .foregroundColor(.black)
                                                                    Text("Eat all")
                                                                        .font(.system(size: 15))
                                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                                } //Apply all
                                                            }
                                                            .frame(maxWidth: .infinity, maxHeight: 40, alignment: .topLeading)
                                                            HStack {
                                                                NavigationLink(
                                                                    destination: EditNameView(nameItem: name, groupList: self.$groupList, foodList: self.foodList)
                                                                ) {
                                                                    Image(systemName: !editIsOn ? "square.and.pencil" : "square.and.pencil")
                                                                        .resizable()
                                                                        .aspectRatio(contentMode: .fit)
                                                                        .frame(width: 15, height: 15)
                                                                        .foregroundColor(.black)
                                                                }
                                                                .onAppear() {
                                                                    self.refresh.toggle()
                                                                }
                                                                Button(action: {
                                                                    nameList.remove(at:nameList.firstIndex(of: name.wrappedValue)!)
                                                                    self.uncheckGroup(groupItem: group)
                                                                    self.deleteIsOn.toggle()
                                                                }, label: {
                                                                    Image(systemName: !deleteIsOn ? "trash" : "trash")
                                                                        .resizable()
                                                                        .aspectRatio(contentMode: .fit)
                                                                        .frame(width: 15, height: 15)
                                                                        .foregroundColor(.black)
                                                                })
                                                            }
                                                            .frame(maxHeight: 30, alignment: .top)
                                                        } // NameItem
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                    } // if name in group
                                                } // for Name in group
                                            } //Names
                                        } //Group
                                        .padding()
                                        .background(.white)
                                        .cornerRadius(15)
                                        .padding(.bottom, 5)
                                    } // if group.IsCheck
                                } //for group in
                            }// ScrollView
                        } // else
                    } //Body
                    .frame(width: .infinity)
                    .frame(maxWidth: .infinity, alignment: .top)
                    .padding(.top, 10)
                    .padding([.leading, .trailing], 30)
                    Spacer()
                } // Screen
            } // ZStack
            .ignoresSafeArea(edges: .top)
        } // NavigationView
        .accentColor(.white)
//        .navigationViewStyle(.stack)
        .onAppear() {
            self.refresh.toggle()
        }
    }
}
