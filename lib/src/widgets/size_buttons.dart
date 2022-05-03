import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/shoe_provider.dart';

class SizeButtons extends StatelessWidget {
  const SizeButtons({Key? key}) : super(key: key);

  static const _sizes = [7, 7.5, 8, 8.5, 9.0, 9.5];
  static const _maxHeight = 55.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        /// Se podria pasar como parametro restando paddings al size.width pero esto lo hace mas autonomo
        final width = constrains.maxWidth;
        
        final buttonWidth = width / _sizes.length;
        /// El gap es proporcional al tamaño de los botones que a su vez es proporcional al numero de botones
        final gap = buttonWidth * 0.12;

        return Consumer<ShoeProvider>(
          builder: (_, shoe, __) {
            /// El widget Wrap consume mas recursos que el Row, sin embargo como son pocos elementos no hay problema
            /// otra ventaja esque es un poco mas transparente la funcionalidad, mientras que con el row, se debe
            /// insertar un row anidado y muchos flexible ademas, de que el spacing que se tiene aqui como propiedad
            /// se debe implementar con SizedBox en los extremos, por lo que es mas complicado de leer el codigo
            /// Por el momento se escogera este por que fucniona bien y es mas limpio  
            return Wrap(
              alignment: WrapAlignment.center,
              spacing: gap,
              children: [
                ...List.generate(_sizes.length, (index) {
                  final selected = index == shoe.selectedSize;
                      
                  return GestureDetector(
                    onTap: () => shoe.selectedSize = index,
                    /// Para el caso del Wrap tenemos que definir un ConstrainedBox a cada elemento para mantener
                    /// al limite sus dimensiones y que el AspectRatio funcione correctamente, si se coloca por fuera
                    /// como en el Row el AspectRatio no sabra las dimensiones (que es lo que hace el flebox en el Row)
                    child: ConstrainedBox(
                      /// Cuando son muchos elementos el width es el maximo y el aspect da el heigh correspondiente
                      /// cuando son pocos el width es grande pero el height es maximo y el aspec da el width
                      constraints: BoxConstraints(
                        maxWidth: buttonWidth - gap,
                        maxHeight: _maxHeight
                      ),
                      child: AspectRatio(/// Su parent debe tener una dimension definida
                        aspectRatio: 1,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: selected ? const Color(0xffF1A23A) : Colors.white,
                            boxShadow:[ 
                              BoxShadow(
                                color: const Color(0xffF1A23A),
                                blurRadius: selected ? 10 : 0,
                                spreadRadius: selected ? 3 : 0,
                              )
                            ]
                          ),
                          child: Material( /// Para evitar errore en el hero (modo stack)
                            type: MaterialType.transparency, 
                            child: Text(
                              _sizes[index].toString(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: selected ? Colors.white : const Color(0xffF1A23A)
                              )
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            );
          },
        );
      }
    );
  }
}

/// Solucion del los botones adaptables con Row
// Con esto impedimos que el height crezca mucho cuando hay pocos elementos
// return ConstrainedBox(
//   constraints: const BoxConstraints(maxHeight: _maxHeight),
//   /// Forma 1 de conseguir la fila de botones adaptables a mas elementos
//   child: Row( 
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       ...List.generate(_sizes.length, (index) {
//         final selected = index == shoe.selectedSize;
//
//         /// Necesario para setearle un width al row, el flex se adapta al contenido
//         return Flexible(
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SizedBox(width: gap),
//               Flexible( ///Necesario para determinar el width del cuadrado
//                 child: GestureDetector(
//                   onTap: () => shoe.selectedSize = index,
//                   /// Con el aspectRatio se consiguen diferentes relaciones de width/height
//                   /// sin conocer uno de estos o ninguno (calculado implicitamente)
//                   child: AspectRatio(
//                     aspectRatio: 1,
//                     child: Container(
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12.0),
//                         color: selected ? const Color(0xffF1A23A) : Colors.white,
//                         boxShadow:[ 
//                           BoxShadow(
//                             color: const Color(0xffF1A23A),
//                             blurRadius: selected ? 10 : 0,
//                             spreadRadius: selected ? 3 : 0,
//                           )
//                         ]
//                       ),
//                       child: Material( /// Para evitar errore en el hero (modo stack)
//                         type: MaterialType.transparency, 
//                         child: Text(
//                           _sizes[index].toString(),
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: selected ? Colors.white : const Color(0xffF1A23A)
//                           )
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(width: gap)
//             ],
//           ),
//         );
//       }),
//     ],
//   ),
// );