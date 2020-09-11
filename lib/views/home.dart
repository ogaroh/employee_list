import 'package:employees_list/constants.dart';
import 'package:employees_list/custom/loader.dart';
import 'package:employees_list/models/employee.dart';
import 'package:employees_list/services/http_service.dart';
import 'package:employees_list/views/details.dart';
import 'package:flutter/material.dart';

final HttpService httpService = HttpService();

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.none &&
                        snapshot.hasData == null) {
                      print('${snapshot.connectionState.toString()}');
                      return Container(
                        child: Text(
                          'An error occured. Please check your internet connection.',
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      print('${snapshot.connectionState.toString()}');
                      return Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 5,
                          bottom: MediaQuery.of(context).size.height / 5,
                        ),
                        child: Container(
                          color: kDefaultWhite,
                          child: Column(
                            children: [
                              CustomLoader(),
                              Text(
                                'Loading Employees... Please Wait',
                                style: TextStyle(color: kBrandBlack),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      print('${snapshot.connectionState.toString()}');
                      return Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.warning,
                                size: 35,
                                color: kWarningOrange,
                              ),
                            ),
                            Text(
                              'An error occured. ${snapshot.error.toString()}',
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.connectionState ==
                            ConnectionState.done &&
                        snapshot.hasData) {
                      print('${snapshot.connectionState.toString()}');
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          Employee employee = snapshot.data[index];
                          return Column(
                            children: [
                              ListTile(
                                leading: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 1.5,
                                      color: kDefaultBlue,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: CircleAvatar(
                                      radius: 50.0,
                                      backgroundImage: NetworkImage(
                                        employee.avatar,
                                      ),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  "${employee.firstName} ${employee.lastName}",
                                ),
                                subtitle: Text(
                                  "${employee.email}",
                                ),
                                trailing: Text("${employee.id}"),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EmployeeDetails(
                                        employee: employee,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Divider(),
                            ],
                          );
                        },
                      );
                    }
                    return Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.warning,
                              size: 35,
                              color: kWarningOrange,
                            ),
                          ),
                          Text(
                              'Could not get vehicles. Please ensure you\'re still signed in.'),
                        ],
                      ),
                    );
                  },
                  future: httpService.getEmployees(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
