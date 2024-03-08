import SwiftUI

struct GuideView: View {
    @State var picIndex: Int = 1
    
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
                            Text("Guide")
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
               VStack { // body
                    Image("\(picIndex)")
                        .renderingMode(.original)
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 300, alignment: .top)
                } // body
                    .frame(width: .infinity)
                    .frame(maxWidth: .infinity, alignment: .top)
                    .padding(.top, 10)
                    .padding([.leading, .trailing], 30)
                Spacer()
            } // Screen
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
                            Text("Guide")
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(.trailing, 30)
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
                VStack {
                    HStack {
                        Button(action: {
                            if (picIndex > 1) {
                                picIndex -= 1
                            }
                        }, label: {
                            Text("Back")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        })
                        
                        Button(action: {
                            if (picIndex < 17) {
                                picIndex += 1
                            }
                        }, label: {
                            Text("Next")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                                .frame(alignment: .trailing)
                                .padding(.trailing, 30)
                        })
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                    .frame(maxWidth: .infinity, alignment: .top)
                    .padding(.top, 10)
                    .padding([.leading, .trailing], 30)
                Spacer()
            } // Screen
        } // ZStack
        .ignoresSafeArea(edges: .top)
    }
}


