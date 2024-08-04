import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:volunteer_linker/core/enums.dart';

import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../opportunity/data/model/opportunity.dart';
import '../../../profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import '../bloc/home_page_bloc.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/opportunity_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PagingController<int, Opportunity> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    _fetchPage(0);

    context.read<ProfileBloc>().add(
          GetProfile(
            state: context.read<ProfileBloc>().state,
          ),
        );
  }

  void _fetchPage(int pageKey) {
    context.read<HomePageBloc>().add(FetchPostsEvent(
          state: context.read<HomePageBloc>().state,
        ));
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  void _onItemTapped(CurrentPage currentPage, AuthState authState) {
    BlocProvider.of<AuthBloc>(context)
        .add(ChangePageEvent(changePage: currentPage, state: authState));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Home Page'),
            centerTitle: true,
            leading: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
          ),
          drawer: CustomDrawer(
            authState: authState,
            onItemTapped: _onItemTapped,
          ),
          body: BlocBuilder<HomePageBloc, HomePageState>(
            builder: (context, state) {
              switch (state.status) {
                case PostStatus.failure:
                  return const Center(child: Text('Failed to fetch posts'));
                case PostStatus.success:
                  if (state.opportunities.isEmpty) {
                    return const Center(child: Text('No posts available'));
                  }
                  _pagingController.value = PagingState(
                    itemList: state.opportunities,
                    error: null,
                    nextPageKey:
                        state.hasReachedMax ? null : state.opportunities.length,
                  );
                  return PagedListView<int, Opportunity>(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<Opportunity>(
                      itemBuilder: (context, item, index) => OpportunityCard(
                        organizationName: item.organizationName,
                        createdAt: item.createdAt ?? DateTime.now(),
                        address: item.location.readableAddress,
                        imageUrl: item.imageUrl,
                        description: item.description,
                        organizationLogoUrl: item.organizationLogoUrl,
                        participants: item.registeredUsers.length,
                        onApply: () {},
                      ),
                    ),
                  );
                case PostStatus.initial:
                default:
                  return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        );
      },
    );
  }
}
