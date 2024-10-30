import 'package:flavour_lab/app/colors/colors.dart';
import 'package:flavour_lab/app/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return MyWidget().showLoadingWidget();
        }
        final data = controller.dataDetail.value;
        return Stack(
          children: [
            Image.network(
              data.strMealThumb,
              height: 412,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 50,
              left: 28,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back_ios_new_outlined),
                ),
              ),
            ),
            Positioned(
              top: 50,
              right: 28,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: SvgPicture.asset('assets/icons/addBookmark.svg'),
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.56,
              minChildSize: 0.56,
              maxChildSize: 0.88,
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              'assets/icons/drag.svg',
                            ),
                          ),
                        ),
                        const SizedBox(height: 17),
                        Expanded(
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.strMeal,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'myfont',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  data.strArea,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'myfont',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Instructions',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Obx(() {
                                  final instructions =
                                      controller.getDisplayedInstructions();

                                  // Memisahkan string menjadi baris
                                  final instructionLines =
                                      instructions.split('\n');

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: instructionLines.map((line) {
                                      return line.isNotEmpty
                                          ? Row(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start, // Menyelaraskan teks dengan nomor
                                              children: [
                                                SizedBox(
                                                  width: 20,
                                                  child: Text(
                                                    '${instructionLines.indexOf(line) + 1}. ',
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      fontFamily: 'myfont',
                                                      color: grey,
                                                    ),
                                                  ),
                                                ),

                                                const SizedBox(
                                                  width: 10,
                                                ), // Menampilkan nomor
                                                Expanded(
                                                    child: Text(
                                                  line,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    fontFamily: 'myfont',
                                                    color: grey,
                                                  ),
                                                )), // Teks akan mengambil sisa ruang yang tersedia
                                              ],
                                            )
                                          : SizedBox(); // Kembalikan widget kosong jika baris kosong
                                    }).toList(),
                                  );
                                }),
                                // Tampilkan 'See more' jika instruksi lebih dari 5 baris
                                if (data.strInstructions.split('\n').length > 5)
                                  GestureDetector(
                                    onTap: () {
                                      print(
                                          'See more tapped'); // Debugging untuk memastikan ini dipanggil
                                      controller.toggleExpanded();
                                    },
                                    child: Obx(() {
                                      // Gunakan Obx di sini untuk memperbarui teks secara real-time
                                      return Text(
                                        controller.getSeeMoreText(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'myfont',
                                          color: green,
                                        ),
                                      );
                                    }),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        );
      }),
    );
  }
}
