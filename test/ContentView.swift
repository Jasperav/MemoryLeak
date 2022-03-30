import Combine
import SwiftUI

struct ContentView: View {
    @State var present = false

    var body: some View {
        Button("click me") {
            present = true
        }
        .sheet(isPresented: $present) {
            MediaPickerViewWrapperTest(isPresented: $present)
        }
    }
}

class Custom: UIImagePickerController {
    deinit {
        print("DEINIT")
    }
}

struct MediaPickerViewWrapperTest: UIViewControllerRepresentable {
    let isPresented: Binding<Bool>

    func makeUIViewController(context: Context) -> Custom {
        let c = Custom()

        c.delegate = context.coordinator

        return c
    }

    func updateUIViewController(_: Custom, context _: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(
            isPresented: isPresented
        )
    }
}

final class Coordinator: NSObject, UINavigationControllerDelegate,
    UIImagePickerControllerDelegate
{
    @Binding var isPresented: Bool

    init(
        isPresented: Binding<Bool>
    ) {
        _isPresented = isPresented
    }

    func imagePickerController(
        _: UIImagePickerController,
        didFinishPickingMediaWithInfo _: [
            UIImagePickerController
                .InfoKey: Any
        ]
    ) {
        isPresented = false
    }

    func imagePickerControllerDidCancel(_: UIImagePickerController) {
        isPresented = false
    }
}
