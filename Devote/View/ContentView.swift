//
//  ContentView.swift
//  Devote
//
//  Created by Moloud on 10/19/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - PROPERTY
    @State var task:String = ""
    @State private var showNewTaskItem: Bool = false
    
    
    // FETCHING DATA
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    // MARK: - FUNCTIONS
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            ZStack {
                // MARK: - MAIN VIEW
                VStack {
                    // MARK: - HEADER
                    Spacer(minLength: 80)
                    // MARK: - NEW TASK BUTTON
                    Button(action:{
                        showNewTaskItem = true
                    }, label:{
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        Text("New Task")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                    })
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .leading, endPoint: .trailing)
                        .clipShape(Capsule()))
                    .shadow(color: Color(red:0, green: 0, blue:0, opacity: 0.25), radius: 8, x:0, y:4.0)
                    // MARK: - TASKS
                    List {
                            ForEach(items) { item in
                                
                                VStack(alignment: .leading) {
                                    Text(item.task ?? "")
                                        .font(.headline)
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }//: LIST ITEM
                            }
                            .onDelete(perform: deleteItems)
                        }//: LIST
                    .listStyle(InsetGroupedListStyle())
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3),radius: 12)
                    .padding(.vertical,0)
                    .frame(maxWidth: 640)
                    }//: VSTACK
              
                // MARK: - NEW TASK ITEM
                if showNewTaskItem{
                    BlankView()
                        .onTapGesture {
                            withAnimation() {
                                showNewTaskItem = false
                            }
                        }
                    NewTaskItemView(isShowing: $showNewTaskItem)
                }
            }//: ZSTACK
            .onAppear() {
              UITableView.appearance().backgroundColor = UIColor.clear
            }
            .navigationBarTitle("Daily Tasks", displayMode: .large)
          
            .toolbar {
                #if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing){
                    EditButton()
                }
                #endif
            }//: TOOLBAR
            .background(
              BackgroundImageView()
                .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
            )
            .background(
              backgroundGradient.ignoresSafeArea(.all)
            )

            }//: NAVIGATION
      
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }



#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
