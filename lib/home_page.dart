import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:pull_to_refresh_app/cubit/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_app/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DataListUser> itemsShow = <DataListUser>[];
  List<DataListUser> itemsApi = <DataListUser>[];
  int page = 1;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<UserCubit>().getUser(page: "1");
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));

    // condition if success refresh data
    itemsShow.clear();
    page=1;
    context.read<UserCubit>().getUser(page: '1');
    _refreshController.refreshCompleted();

    // condition if failed refresh data
    // _refreshController.refreshFailed();
  }

  onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());

    page = page + 1;

    context.read<UserCubit>().getUser(page: page.toString());

    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserSuccess) {
            itemsShow.addAll(state.dataListUser);
          }
          return SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              // header: WaterDropHeader(),
              footer: CustomFooter(
                builder: (BuildContext context, LoadStatus? mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = const Text("pull up load");
                  } else if (mode == LoadStatus.loading) {
                    body = const CupertinoActivityIndicator(); //used CircularProgressIndicator() for material design (android)
                  } else if (mode == LoadStatus.failed) {
                    body = const Text("Load Failed!Click retry!");
                  } else if (mode == LoadStatus.canLoading) {
                    body = const Text("release to load more");
                  } else {
                    body = const Text("No more Data");
                  }
                  return SizedBox(
                    height: 55.0,
                    child: Center(child: body),
                  );
                },
              ),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: onLoading,
              child: ListView.builder(
                itemBuilder: (c, i) {
                  return Card(
                      child: Center(child: Text(itemsShow[i].firstName)));
                },
                itemExtent: 100.0,
                itemCount: itemsShow.length,
              ));
        },
      ),
    );
  }
}
