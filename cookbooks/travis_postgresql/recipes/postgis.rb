ppv = node['travis_postgresql']['postgis_version']

# package(
#   TravisPostgresqlMethods.pg_versions(node).map do |v|
#     %W[
#       postgresql-#{v}-postgis-#{ppv}
#       postgresql-#{v}-postgis-#{ppv}-scripts
#     ]
#   end.flatten
# )

package 'postgresql-9.5-postgis-2.2'
package 'postgresql-9.5-postgis-scripts'