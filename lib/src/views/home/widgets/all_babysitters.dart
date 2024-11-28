import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants/styles.dart';
import 'package:babysitterapp/src/components.dart';
import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/models.dart';

class AllBabysittersView extends HookConsumerWidget {
  const AllBabysittersView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = useScrollController();
    final ValueNotifier<int> pageSize = useState(10);
    final ValueNotifier<bool> isLoadingMore = useState(false);
    final ValueNotifier<bool> hasMoreData = useState(true);
    final ValueNotifier<String> searchQuery = useState('');
    final String debouncedSearch =
        useDebounce(searchQuery.value, const Duration(milliseconds: 300));

    final Stream<List<UserAccount>> babysittersStream = useMemoized(
      () => ref.read(authControllerService.notifier).getBabysittersStream(),
    );
    useStream(babysittersStream);

    useEffect(() {
      void onScroll() {
        if (scrollController.position.pixels >=
                scrollController.position.maxScrollExtent * 0.95 &&
            !isLoadingMore.value &&
            hasMoreData.value) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            isLoadingMore.value = true;
            Future<void>.delayed(const Duration(milliseconds: 500), () {
              if (hasMoreData.value) {
                pageSize.value += 10;
                isLoadingMore.value = false;
              }
            });
          });
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, const <Object?>[]);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Babysitters',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomTextInput(
              hintText: 'Search babysitters...',
              fieldLabel: 'Search babysitters...',
              prefixIcon: const Icon(Icons.search),
              onChanged: (String value) {
                searchQuery.value = value;
                pageSize.value = 10;
              },
              onClear: () {
                searchQuery.value = '';
                pageSize.value = 10;
              },
              borderRadius: 30,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              fillColor: Colors.white,
            ),
          ),
        ),
      ),
      body: StreamBuilder<List<UserAccount>>(
        stream: babysittersStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<UserAccount>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: GlobalStyles.primaryButtonColor,
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final List<UserAccount> allUsers = snapshot.data ?? <UserAccount>[];
          if (allUsers.isEmpty) {
            return const Center(
              child: Text('No babysitters found'),
            );
          }

          final List<UserAccount> filteredUsers = debouncedSearch.isEmpty
              ? allUsers
              : allUsers
                  .where((UserAccount user) =>
                      user.name
                          ?.toLowerCase()
                          .contains(debouncedSearch.toLowerCase()) ??
                      false)
                  .toList();

          if (filteredUsers.isEmpty) {
            return const Center(
              child: Text('No matching babysitters found'),
            );
          }

          final List<UserAccount> paginatedUsers =
              filteredUsers.take(pageSize.value).toList();

          // Update hasMoreData based on remaining items
          WidgetsBinding.instance.addPostFrameCallback((_) {
            hasMoreData.value = paginatedUsers.length < filteredUsers.length;
          });

          return ListView.builder(
            controller: scrollController,
            padding: const EdgeInsets.all(16),
            itemCount: paginatedUsers.length + (hasMoreData.value ? 1 : 0),
            itemBuilder: (BuildContext context, int index) {
              if (index == paginatedUsers.length) {
                if (!hasMoreData.value) return const SizedBox.shrink();

                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: isLoadingMore.value
                        ? const CircularProgressIndicator(
                            color: GlobalStyles.primaryButtonColor,
                          )
                        : ElevatedButton(
                            onPressed: () {
                              pageSize.value += 10;
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: GlobalStyles.primaryButtonColor,
                            ),
                            child: const Text('Load More'),
                          ),
                  ),
                );
              }

              final UserAccount user = paginatedUsers[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: CachedAvatar(
                    imageUrl: user.profileImg,
                    radius: 25,
                    showOnlineStatus: true,
                    isOnline: user.onlineStatus,
                    showVerificationStatus: true,
                    isVerified: user.emailVerified != null &&
                        user.validIdVerified != null,
                  ),
                  title: Text(
                    user.name ?? 'No Name',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(user.address ?? 'No Address'),
                      if (user.description != null &&
                          user.description!.isNotEmpty)
                        Text(
                          user.description!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                  onTap: () {
                    // Handle selection
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
