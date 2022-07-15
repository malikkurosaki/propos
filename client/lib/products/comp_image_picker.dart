import 'dart:convert';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/utils/g_val.dart';
import 'package:client/utils/util_http.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:http/http.dart' as http;

import '../utils/util_value.dart';

class CompImagePicker extends StatelessWidget {
  CompImagePicker({Key? key, this.onImageNameChange}) : super(key: key);
  final withImage = false.obs;
  final ImagePicker _picker = ImagePicker();
  final hasilGambar = Uint8List(0).obs;
  final imageName = "".obs;
  final Function(String value)? onImageNameChange;
  final gambarIni = "".obs;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Obx(
        () => SizedBox(
          width: sizingInformation.isMobile ? double.infinity : 360,
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade300
              ),
              
            ),
            child: Column(
              children: [
                CheckboxListTile(
                  title: const Text("Image", style: TextStyle(fontSize: 32)),
                  value: withImage.value,
                  onChanged: (value) {
                    withImage.value = !withImage.value;
                  },
                ),
                Visibility(
                  visible: withImage.value,
                  child: Column(
                    children: [
                      // internal source
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                          elevation: 0,
                          color: Colors.grey[100],
                          onPressed: () async {
                            // image picker
                            final image = await _picker.pickImage(source: ImageSource.gallery);

                            // get file
                            final file = http.MultipartFile.fromBytes(
                              "image",
                              await image!.readAsBytes(),
                              filename: "propos.png",
                            );

                            // try puload to server with multipart file
                            final respons =
                                http.MultipartRequest("POST", Uri.parse("http://localhost:3000/api/v1/upload"));
                            respons.files.add(file);
                            // add header
                            respons.headers.addAll(
                                {"Authorization": "Bearer ${UtilValue.token}", "Content-Type": "multipart/form-data"});

                            final response = await respons.send().then((value) => value.stream.bytesToString());
                            final result = jsonDecode(response);

                            if (result['success']) {
                              // set image to hasilGambar
                              final sementaraImage = await image.readAsBytes();
                              hasilGambar.value = sementaraImage;
                              imageName.value = result['name'];
                              // body['image'] = result['name'];
                              onImageNameChange!(result['name']);
                            } else {
                              EasyLoading.showError(result['message'].toString());
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.add_a_photo,
                                  size: 32,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Pick Image"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () => Visibility(
                          visible: hasilGambar.value.isNotEmpty,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.memory(
                                  hasilGambar.value,
                                  height: 200,
                                ),
                              ),
                              Chip(
                                label: Text(
                                  imageName.value.toString(),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      // from server source
                      Obx(
                        () => Visibility(
                          visible: imageName.value.isEmpty,
                          child: SizedBox(
                            width: double.infinity,
                            height: 290,
                            child: FutureBuilder<http.Response>(
                              future: UtilHttp.availableImage(),
                              builder: (context, snapshot) => snapshot.connectionState != ConnectionState.done
                                  ? const Text('loading ...')
                                  : Container(
                                        padding: const EdgeInsets.all(8),
                                        width: double.infinity,
                                        child: 
                                        GridView.extent(
                                          maxCrossAxisExtent: 360 / 3,
                                          children: [
                                            
                                            for (final image in List.from(jsonDecode(snapshot.data!.body)))
                                              InkWell(
                                                onTap: () {
                                                  gambarIni.value = image;
                                                  onImageNameChange!(image);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: gambarIni.value == image ? Colors.blue : Colors.white,
                                                        width: 4),
                                                  ),
                                                  padding:
                                                      gambarIni.value == image ? const EdgeInsets.all(12) : const EdgeInsets.all(0),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        UtilHttp.hostImage + "/" +GVal.user.value.val['id'] + "/" + image,
                                                  ),
                                                ),
                                              )
                                          ],
                                        ),
                                      )
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                // display image
              ],
            ),
          ),
        ),
      ),
    );
  }
}
