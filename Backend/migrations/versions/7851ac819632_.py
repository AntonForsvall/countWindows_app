"""empty message

Revision ID: 7851ac819632
Revises: 
Create Date: 2019-10-26 22:30:52.269937

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '7851ac819632'
down_revision = None
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('counters',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('user_id', sa.Integer(), nullable=True),
    sa.Column('image', sa.String(), nullable=True),
    sa.Column('value', sa.Integer(), nullable=True),
    sa.Column('date', sa.DateTime(), nullable=True),
    sa.ForeignKeyConstraint(['user_id'], ['users.id'], ),
    sa.PrimaryKeyConstraint('id')
    )
    op.alter_column('users', 'lastname',
               existing_type=sa.VARCHAR(),
               nullable=True)
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.alter_column('users', 'lastname',
               existing_type=sa.VARCHAR(),
               nullable=False)
    op.drop_table('counters')
    # ### end Alembic commands ###
