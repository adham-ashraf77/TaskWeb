import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:taskweb/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // HomeCubit.get(context).getData();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Upcoming"),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () async {
              final picked = await showDateRangePicker(
                context: context,
                lastDate: DateTime(2099),
                firstDate: DateTime(2019),
              );
              if (picked != null && picked != null) {
                print(picked.start);
                print(picked.end);
              }
            },
            icon: const Icon(Icons.date_range_sharp)),
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return state is HomeLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(top: 10, bottom: 15),
                  itemCount: HomeCubit.get(context).listData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              )),
                          child: Column(
                            children: [
                              CachedNetworkImage(
                                imageUrl: HomeCubit.get(context)
                                    .listData[index]
                                    .links
                                    .patch
                                    .small,
                                fit: BoxFit.contain,
                                imageBuilder: (ctx, image) {
                                  return Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    width: MediaQuery.of(context).size.width *
                                        0.28,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      image: DecorationImage(
                                        image: image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(HomeCubit.get(context).listData[index].name),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(DateFormat.yMEd().format(
                                  HomeCubit.get(context)
                                          .listData[index]
                                          .staticFireDateUtc ??
                                      DateTime.now())),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
