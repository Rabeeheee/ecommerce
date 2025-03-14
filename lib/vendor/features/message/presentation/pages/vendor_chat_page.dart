import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';
import 'package:tech_haven/core/common/widgets/chat_tile.dart';

class VendorChatPage extends StatelessWidget {
  const VendorChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              toolbarHeight: 50,
              forceElevated: false,
              scrolledUnderElevation: 0,
              elevation: 0,
              automaticallyImplyLeading: false,
              snap: true,
              // pinned: true,

              floating: true,
              //the whole height of the appBar
              // expandedHeight: 40,
              //the height of the app bar when it is collapsed or scrolled
              collapsedHeight: 56,
              stretchTriggerOffset: 100,
              onStretchTrigger: () async {},
              flexibleSpace: const FlexibleSpaceBar(
                background: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: AppBarSearchBar(
                    hintText: 'Search Chats',
                    favouriteIconNeeded: false,
                    deliveryPlaceNeeded: false,
                  ),
                ),
                expandedTitleScale: 1,
                centerTitle: true,
              ),
            ),
          ],
          body: ListView.builder(
            itemCount: 40,
            itemBuilder: (context, index) {
              return const ChatTile(
                name: 'name',
                lastMessage: 'lastMessage',
                image: '',
              );
            },
          ),
        ),
      ),
    );
  }
}
