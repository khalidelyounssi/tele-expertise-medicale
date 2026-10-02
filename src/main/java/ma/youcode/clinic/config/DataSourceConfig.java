package ma.youcode.clinic.config;

import com.mysql.cj.jdbc.MysqlDataSource;

import javax.sql.DataSource;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class DataSourceConfig {

    private static DataSource dataSource;

    private DataSourceConfig() {
    }

    public static DataSource getDataSource() {

        if (dataSource == null) {

            Properties properties = new Properties();
            try(InputStream input = DataSourceConfig.class.getClassLoader().getResourceAsStream("db.properties")){
                properties.load(input);

            }catch(IOException e){
                System.err.println("error: "+e.getMessage());
            }

            MysqlDataSource mysqlDataSource = new MysqlDataSource();

            mysqlDataSource.setServerName(properties.getProperty("db.url"));
            mysqlDataSource.setPortNumber(Integer.parseInt(properties.getProperty("db.port")));
            mysqlDataSource.setDatabaseName(properties.getProperty("db.name"));
            mysqlDataSource.setUser(properties.getProperty("db.user"));
            mysqlDataSource.setPassword(properties.getProperty("db.password"));

            dataSource = mysqlDataSource;
        }

        return dataSource;
    }
}