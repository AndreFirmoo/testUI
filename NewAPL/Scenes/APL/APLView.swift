//
//  APLView.swift
//  NewAPL
//
//  Created by Andre Firmo on 3/11/24.
//

import SwiftUI

struct APLView: View {
    @State var changeArrow: Bool = false
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader(content: { geometry in
                    Button(action: {
                        changeArrow.toggle()
                    }, label: {
                        HStack {
                            Text("S")
                                .foregroundStyle(Color.black)
                                .font(.system(size: 25))
                                .background {
                                    Circle()
                                        .foregroundStyle(.white)
                                        .frame(width: 40, height: 40, alignment: .leading)

                                }.frame(width: 75, height: 75, alignment: .leading)
                            VStack(alignment: .leading) {
                                Text("Olá, Sant'Ana")
                                    .foregroundStyle(Color.white)
                                Text("Agência **00 conta ***00-1")
                                    .foregroundStyle(Color.white)
                            }
                            .padding(.leading, -40)
                            Spacer()
                            let nameArrow = changeArrow ? "arrowtriangle.up.fill":"arrowtriangle.down.fill"
                            Image(systemName: nameArrow)
                                .font(.title2)
                                .foregroundStyle(Color.white)
                            Spacer()
                        }
                    })
                })
                .padding(.leading, 15)
            }
            .padding(.leading, 15)
            .background(Color.blue)
            .halfSheet(showSheet: $changeArrow) {
                ZStack {
                    Color.white
                    
                }.ignoresSafeArea()
            } onEnd: {
                print("Dismiss")
            }
        }.navigationBarBackButtonHidden(true)
    }
}

extension View {
    func halfSheet<SheetView: View>(showSheet:Binding<Bool>, @ViewBuilder sheetView: @escaping ()-> SheetView, onEnd: @escaping ()->()) -> some View {
        return self.background {
            HalfSheetHelper(sheetView: sheetView(), showSheet: showSheet, onEnd: onEnd)
        }
    }
}



struct HalfSheetHelper<SheetView: View>: UIViewControllerRepresentable {
    
    var sheetView: SheetView
    @Binding var showSheet: Bool
    var onEnd: ()->()

    let controller = UIViewController()

    func makeCoordinator() -> SheetCoordinator {
        return SheetCoordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        controller.view.backgroundColor = .clear
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        if showSheet {
            let sheetController = CustomHostingController(rootView: sheetView)
            sheetController.presentationController?.delegate = context.coordinator
            uiViewController.present(sheetController, animated: true) {
                DispatchQueue.main.async {
                    self.showSheet.toggle()
                }
            }
        }
    }
    
    class SheetCoordinator: NSObject, UISheetPresentationControllerDelegate {
        var parent: HalfSheetHelper
        init(parent: HalfSheetHelper) {
            self.parent = parent
        }
        
        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            parent.onEnd()
        }
    }
}

class CustomHostingController<Content: View>: UIHostingController<Content> {
    override func viewDidLoad() {
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()]
            presentationController.prefersGrabberVisible = true
        }
    }
}

#Preview {
    APLView()
}
