package ma.youcode.clinic.config;

import com.mysql.cj.jdbc.MysqlDataSource;

import javax.sql.DataSource;

public class DataSourceConfig {

    private static DataSource dataSource;

    private DataSourceConfig() {
    }

    public static DataSource getDataSource() {

        if (dataSource == null) {

            MysqlDataSource mysqlDataSource = new MysqlDataSource();

            mysqlDataSource.setServerName("localhost");
            mysqlDataSource.setPortNumber(3306);
            mysqlDataSource.setDatabaseName("tele_expertise_medicale");
            mysqlDataSource.setUser("root");
            mysqlDataSource.setPassword("");

            dataSource = mysqlDataSource;
        }

        return dataSource;
    }
}